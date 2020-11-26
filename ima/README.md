# 完整性度量架构（IMA/EVM）

## 介绍

### IMA

**IMA**，全称 Integrity Measurement Architecture（完整性度量架构），是内核中的一个子系统，通过在系统调用中增加钩子，能够对访问的文件进行度量。

根据 IMA wiki 的定义，内核完整性子系统的功能可以被分为三部分：

- 度量（measure）：检测对文件的意外或恶意修改，用于本地或远程完整性证明。
- 评估（appraise）：度量文件并与一个存储在扩展属性中的 good value 作比较，控制对文件的访问。
- 审计（audit）：将度量结果写到系统日志中，用于审计。

### 摘要列表扩展

**摘要列表扩展**是对原生 IMA 机制的增强，该扩展的任务是将用于参考的文件摘要上传至内核中，在被 IMA 度量和评估模块调用时，检索内核中的摘要列表并返回结果。EulerOS 使用该机制代替社区原生的 IMA 机制实现应用程序的安全启动：

- 对于度量场景，现在在内核中维护一个用于参考的摘要列表，只在文件改变时才写 TPM 中的 PCR（当前尚未支持）。
- 对于评估场景，现在直接使用已上传至内核的摘要值而非文件签名做访问校验，避免了每次访问文件时都执行验签，只在启动前统一执行验签，每次访问文件只进行哈希值比对。

该扩展保证了系统中运行的任何程序都来自软件的发行商而未被篡改，增强了现网环境的安全性，降低了部署的复杂性，提升了开启完整性校验机制时的性能。

## 快速上手

按以下步骤配置开启 IMA 完整性校验：

1. 从官方镜像源安装 openEuler-20.09 ISO：https://mirrors.huaweicloud.com/openeuler/openEuler-20.09/

   > 注：对于安装环境而言，虚拟机和物理机都可行，且 TPM 芯片不是必需的。

2. 使用 openEuler 官方镜像源配置 yum 仓库。

3. 编辑 `/boot/efi/EFI/euleros/grub.cfg` 文件，加入以下参数：

   ```shell
   ima_template=ima-sig ima_policy="exec_tcb|appraise_exec_tcb|appraise_exec_immutable" initramtmpfs ima_hash=sha256 ima_appraise=log evm=allow_metadata_writes evm=x509 ima_digest_list_pcr=11 ima_appraise_digest_list=digest
   ```

   使用 `reboot` 重启系统进入 log 模式，该模式下已开启完整性校验，但不会因校验失败而无法启动。

4. 安装工具包 digest-list-tools 和 ima-evm-utils：

   ```shell
   $ yum install digest-list-tools ima-evm-utils
   ```

5. 执行 `dracut` 重新生成 initramfs：

   ```shell
   $ dracut -f -e xattr
   ```

6. 再次编辑 `/boot/efi/EFI/euleros/grub.cfg` 文件，将 `ima_appraise=log` 改为 `ima_appraise=enforce-evm`：

   ```shell
   ima_template=ima-sig ima_policy="exec_tcb|appraise_exec_tcb|appraise_exec_immutable" initramtmpfs ima_hash=sha256 ima_appraise=enforce-evm evm=allow_metadata_writes evm=x509 ima_digest_list_pcr=11 ima_appraise_digest_list=digest
   ```

   使用 `reboot` 重启即可完成部署。

查看系统当前使用的 IMA 策略：

```shell
$ cat /sys/kernel/security/ima/policy
```

## 参与贡献

请参考 `ima/docs` 目录下的[贡献准则](https://gitee.com/nettingsisyphus/security-facility/blob/master/ima/docs/zh/%E8%B4%A1%E7%8C%AE%E5%87%86%E5%88%99.md)。

## 开发计划

| **需求描述**                                     | **交付版本** | **交付时间** | 进度                      |
| ------------------------------------------------ | ------------ | ------------ | ------------------------- |
| 内核态支持 IMA 摘要列表特性                      | 20.09        | 2020 年 9 月 | 已完成 :heavy_check_mark: |
| OBS 支持摘要列表构建                             | 20.09        | 2020 年 9 月 | 已完成 :heavy_check_mark: |
| 用户态支持自动标记扩展属性和导入摘要列表         | 20.09        | 2020 年 9 月 | 已完成 :heavy_check_mark: |
| **5.10 内核适配支持 IMA 摘要列表，实现完整 CIV** | 21.03        | 2021 年 3 月 | 开发中 :horse_racing:     |
| 新增 grub 接口，支持 IMA 开箱即用                | 21.03        | 2021 年 3 月 | 开发中 :horse_racing:     |
| 落地 IMA 度量模式，对接远程证明                  | 21.03        | 2021 年 3 月 | 测试中 :eyes:             |
| IMA Digest List 开源 LTP 用例补充                | 21.09        | 2021 年 9 月 | 未开始 :turtle:           |
| 支持第三方构建 IMA 摘要列表                      | 21.09        | 2021 年 9 月 | 开发中 :horse_racing:     |
| **容器场景实现对 IMA 校验的支持**                | 21.09        | 2021 年 9 月 | 未开始 :turtle:           |
| bugfix：修复 KEXEC_KERNEL_CHECK 问题             | 21.03        | 2021 年 3 月 | 开发中 :horse_racing:     |

更多信息请参考[开发计划](https://gitee.com/nettingsisyphus/security-facility/blob/master/ima/docs/zh/%E5%BC%80%E5%8F%91%E8%AE%A1%E5%88%92.md)。

## 参考资料

* [管理员指南可信计算章节](https://openeuler.org/zh/docs/20.09/docs/Administration/%E5%8F%AF%E4%BF%A1%E8%AE%A1%E7%AE%97.html)
* [openEuler 直播视频](https://www.bilibili.com/video/BV1dk4y1171e?from=search&seid=4389855788715605912)