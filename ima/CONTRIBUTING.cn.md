# IMA 贡献准则

首先，感谢您考虑在 openEuler 上为 IMA 做贡献。正是像你这样的人使 IMA 成为 openEuler 系统完整性的的安全基石。

遵循这些准则有助于传达您尊重开发人员管理和开发这个开源项目的时间。作为回报，他们应该在解决您的问题、评估更改并帮助您最终确定您的 PR 时回馈这种尊重。

## 贡献之前

### 了解 IMA 代码分布

IMA 摘要列表并不只是一个内核特性，它还包括了 rpm、dracut、cpio 等多个外围包中的补丁，在开始贡献之前请先参考 [IMA 补丁列表](https://gitee.com/openeuler/security-facility/tree/master/ima/src/README.md)，了解 IMA 对哪些外围包进行了修改。

### 签署 CLA

请在提交第一条 PR 之前签署 [openEuler CLA](https://clasign.osinfra.cn/sign/Z2l0ZWUlMkZvcGVuZXVsZXI=)。

## 如何贡献

### 提交 Issue

本章节指导用户在 openEuler 上提交 IMA 的 Issue。遵循这些准则可帮助维护者和社区理解您的报告，重现行为，并查找相关报告。

#### 是否应该提交 Issue

如果发现安全漏洞，请勿直接创建 Issue，请发送邮件至 [securities@openeuler.org](mailto:securities@openeuler.org)。

任何安全问题都应直接提交给[securities@openeuler.org](mailto:securities@openeuler.org)，以确定您是否正在处理安全问题，请自问以下两个问题：

* 我可以访问一些不属于我的或我不该访问的东西吗？
* 我能禁用其他人访问一些东西吗？

如果这两个问题的答案是“是”，那么您可能正在处理安全问题。但请注意，即使您对这两个问题都回答“否”，您可能仍然在处理安全问题，因此，在不确定的时候请直接发送电子邮件。

如果这不是安全漏洞：

* 在提交缺陷之前，请检查 [Issue 面板](https://gitee.com/openeuler/security-facility/issues)，因为您可能会发现问题已被提出。如果问题存在且仍然未被解决，请对已有问题添加注释，而不要创建新的 Issue。
* 确定问题应该在哪个仓中报告。

#### 如何提交 Issue

* 在 Issue 标题中增加 `[IMA-bugs]` 前缀，例如：

  > [IMA-bugs] IMA appraisal failed but no audit logs were found

* 使用清晰的、描述性的标题概括问题。

* **描述重现问题的确切步骤，尽可能详细**。例如，首先解释您是如何配置内核启动参数和 IMA 策略的。在列出步骤时，**不要仅仅说你做了什么，而是解释你是如何做到的**。例如，您在终端中具体使用了哪个命令。

* 具体举例说明步骤，加上可复制/粘贴的[代码段](https://help.github.com/items/markdown-basics/#multi-line)。

* 描述您遵循步骤后观察到的行为，并指出该行为到底存在什么问题。

* 解释你期望看到什么行为以及为什么。

* 包含截图或动画GIF，显示您遵循所描述的步骤，并清楚地演示问题。您可以使用 [Licecap](https://www.cockos.com/licecap/) 在 macOS 和 windows 上录制 GIF，使用[silentcase](https://github.com/colinkeenan/silentcast) 或 [byzanz](https://github.com/GNOME/byzanz) 在Linux上录制。

* 如果问题与性能或内存有关，请将 [CPU profile capture](https://flight-manual.atom.io/hacking-atom/sections/debugging/#diagnose-runtime-performance) 与您的 Issue 附在一起。

- 如果问题不能由特定动作触发，请描述问题发生前您正在做什么。

### 建议新特性和改进

新特性和改进将作为 *Gitee Issue* 进行跟踪，在 SIG security-facility 中创建 issue 并提供以下信息：

* 在 Issue 标题中增加 `[IMA-enhancements]` 前缀，例如：

  > [IMA-enhancements] Support importing third-party certificate to the kernel

* 使用清晰的、描述性的标题，便于他人阅读。

* 一步一步描述建议的新特性或改进 ，尽可能详细。

* 具体举例说明步骤，加上可复制/粘贴的[代码段](https://help.github.com/items/markdown-basics/#multi-line)。

* 描述当前的行为，解释您期望看到哪些行为和原因。

* 添加截图或动画 GIF 以帮助您演示步骤。您可以使用 [Licecap](https://www.cockos.com/licecap/) 在 macOS 和 windows 上录制 GIF，使用[silentcase](https://github.com/colinkeenan/silentcast) 或 [byzanz](https://github.com/GNOME/byzanz) 在Linux上录制。

* 解释为什么这种增强对大多数 IMA 用户都有用。

- 指定您使用的操作系统的名称和版本。

### 提交 Pull Request

提交 PR 的步骤如下：

1. 如果没有签署 CLA，请[签署 CLA](https://clasign.osinfra.cn/sign/Z2l0ZWUlMkZvcGVuZXVsZXI=)。
2. 将要提交的仓 fork 到个人仓，确保代码和最新主线一致。
3. 在个人仓中修改代码。
4. 在准备好代码后，从个人仓提交 PR 到 openEuler 仓的 openEuler-20.09 分支。

Maintainer 将 PR 合并到主线前，必须确保其满足以下条件：

* 通过了 CI 验证。
* 经过至少 2 名 SIG security-facility 的 maintainer 同意。但如果是 maintainer 创建的PR，只需要审批一次。
* 提交基于当前最新主线代码。

在以上提交满足时，所有 Maintainer 都有权合并 PR。

## 风格指引

### C 编程风格

IMA 的核心代码位于内核，为了保持和上游一致，我们建议采用 [Kernel 编程风格](https://www.kernel.org/doc/html/v4.10/process/coding-style.html)。

### 文档风格

* 使用 Markdown 书写文档。
* 遵循 KISS 原则（Keep It Simple and Stupid），使文档尽可能保持简洁和友好。