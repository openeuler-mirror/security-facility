# 完整性度量架构（IMA/EVM）

## 介绍

**IMA**，全称 Integrity Measurement Architecture（完整性度量架构），是内核中的一个子系统，能够基于自定义策略对通过 execve()、mmap() 和 open() 系统调用访问的文件进行度量，度量结果可被用于<u>本地/远程证明</u>，或者和已有的参考值比较以<u>控制对文件的访问，</u>两种场景都可通过日志进行审计。

根据 IMA wiki 的定义，内核完整性子系统的功能可以被分为三部分：

- 度量（measure）：检测对文件的意外或恶意修改，无论远程还是本地。
- 评估（appraise）：度量文件并与一个存储在扩展属性中的 good value 作比较，控制本地文件完整性。
- 审计（audit）：将度量结果写到系统日志中，用于审计。

**IMA 摘要列表扩展**是对原生 IMA 机制的增强，该扩展的任务是将用于参考的文件摘要上传至内核中，在被 IMA 度量和评估模块调用时，检索内核中的摘要列表并返回结果。EulerOS 使用该机制代替社区原生的 IMA 机制实现应用程序的安全启动：

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

请参考 `ima/docs` 目录下的贡献准则文档。

## 参考资料
* 管理员指南可信计算章节：https://openeuler.org/zh/docs/20.09/docs/Administration/%E5%8F%AF%E4%BF%A1%E8%AE%A1%E7%AE%97.html
* openEuler 直播视频：https://www.bilibili.com/video/BV1dk4y1171e?from=search&seid=4389855788715605912