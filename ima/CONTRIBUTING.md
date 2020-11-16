First off, thank you for considering contributing to IMA on openEuler. It's people like you that make IMA the foundation of openEuler integrity.

Following these guidelines helps to communicate that you respect the time of the developers managing and developing this open source project. In return, they should reciprocate that respect in addressing your issue, assessing changes, and helping you finalize your pull requests.

## What should I know before I get started?

### IMA packages

IMA Digest List Extension is not just a kernel feature. Instead, it includes patches for rpm, dracut, cpio and many other packages. Please look at the [Patch List of IMA](https://gitee.com/openeuler/security-facility/tree/master/ima/src/README.md) before contributing.

### Sign CLA

It's necessary to sign [openEuler CLA](https://clasign.osinfra.cn/sign/Z2l0ZWUlMkZvcGVuZXVsZXI=) before sending a pull request.

## How can I contribute?

### Reporting Bugs

This section guides you through submitting a bug report for IMA on openEuler. Following these guidelines helps maintainers and the community understand your report 📝, reproduce the behavior 💻, and find related reports 🔎.

Before creating bug reports, please check the [issue panel](https://gitee.com/openeuler/security-facility/issues) as you might find out that you don't need to create one. When you are creating a bug report, please **include as many details as possible**. Fill out the **required template**, the information it asks for helps us resolve issues faster.

#### Before Submitting A Bug Report

If you find a security vulnerability, do NOT open an issue. Email [securities@openeuler.org](mailto:securities@openeuler.org) instead.

Any security issues should be submitted directly to [securities@openeuler.org](mailto:securities@openeuler.org) in order to determine whether you are dealing with a security issue, ask yourself these two questions:

- Can I access something that's not mine, or something I shouldn't have access to?
- Can I disable something for other people?

If the answer to either of those two questions are "yes", then you're probably dealing with a security issue. Note that even if you answer "no" to both questions, you may still be dealing with a security issue, so if you're unsure, just email us at [securities@openeuler.org](mailto:securities@openeuler.org).

If it's not a security vulnerability, 

- **Check the FAQs** for a list of common questions and problems.
- **Determine which repository the problem should be reported in**.
- **Perform a cursory search** to see if the problem has already been reported. If it has **and the issue is still open**, add a comment to the existing issue instead of opening a new one.

#### How Do I Submit A (Good) Bug Report?

- Add a prefix `[IMA-bugs]` in the issue title. For example:

  > [IMA-bugs] IMA appraisal failed but no audit logs were found

- **Use a clear and descriptive title** for the issue to identify the problem.

- **Describe the exact steps which reproduce the problem** in as many details as possible. For example, start by explaining how you started Atom, e.g. which command exactly you used in the terminal, or how you started Atom otherwise. When listing steps, **don't just say what you did, but explain how you did it**. For example, if you moved the cursor to the end of a line, explain if you used the mouse, or a keyboard shortcut or an Atom command, and if so which one?

- **Provide specific examples to demonstrate the steps**. Include links to files or GitHub projects, or copy/pasteable snippets, which you use in those examples. If you're providing snippets in the issue, use [Markdown code blocks](https://help.github.com/articles/markdown-basics/#multiple-lines).

- **Describe the behavior you observed after following the steps** and point out what exactly is the problem with that behavior.

- **Explain which behavior you expected to see instead and why.**

- **Include screenshots and animated GIFs** which show you following the described steps and clearly demonstrate the problem. If you use the keyboard while following the steps, **record the GIF with the Keybinding Resolver shown**. You can use [this tool](https://www.cockos.com/licecap/) to record GIFs on macOS and Windows, and [this tool](https://github.com/colinkeenan/silentcast) or [this tool](https://github.com/GNOME/byzanz) on Linux.

- **If the problem is related to performance or memory**, include a [CPU profile capture](https://flight-manual.atom.io/hacking-atom/sections/debugging/#diagnose-runtime-performance) with your report.

- **If the problem wasn't triggered by a specific action**, describe what you were doing before the problem happened and share more information using the guidelines below.

### Suggesting Enhancements

Enhancement suggestions are tracked as **Gitee issues**. After you've determined which repository your enhancement suggestion is related to, create an issue on that repository and provide the following information:

- Add a prefix `[IMA-enhancements]` in the issue title. For example:

  > [IMA-enhancements] Support importing third-party certificate to the kernel

- **Use a clear and descriptive title** for the issue to identify the suggestion.

- **Provide a step-by-step description of the suggested enhancement** in as many details as possible.

- **Provide specific examples to demonstrate the steps**. Include copy/pasteable snippets which you use in those examples, as [Markdown code blocks](https://help.github.com/articles/markdown-basics/#multiple-lines).

- **Describe the current behavior** and **explain which behavior you expected to see instead** and why.

- **Include screenshots and animated GIFs** which help you demonstrate the steps or point out the part of Atom which the suggestion is related to. You can use [this tool](https://www.cockos.com/licecap/) to record GIFs on macOS and Windows, and [this tool](https://github.com/colinkeenan/silentcast) or [this tool](https://github.com/GNOME/byzanz) on Linux.

- **Explain why this enhancement would be useful** to most Atom users and isn't something that can or should be implemented as a [community package](https://github.com/atom/atom/blob/master/CONTRIBUTING.md#atom-and-packages).

- **List some other text editors or applications where this enhancement exists.**

- **Specify which version of Atom you're using.** You can get the exact version by running `atom -v` in your terminal, or by starting Atom and running the `Application: About` command from the [Command Palette](https://github.com/atom/command-palette).

- **Specify the name and version of the OS you're using.**

### Pull Requests

The steps to send a pull request (PR):

1. Sign [openEuelr CLA](https://clasign.osinfra.cn/sign/Z2l0ZWUlMkZvcGVuZXVsZXI=).
2. Fork the repo to your personal repo.
3. Modify in your own repo.
4. When you think the code is ready, send a PR from your repo to **openEuler 20.09**.

A PR can only be merged into master by a maintainer if:

* It is passing CI.
* It has been approved by at least two maintainers of SIG security-facility. If it was a maintainer who opened the PR, only one extra approval is needed.
* It is up to date with current master.

Any maintainer is allowed to merge a PR if all of these conditions are met.

## Styleguides

### C Styleguide

Please refer to [Linux kernel coding style](https://www.kernel.org/doc/html/v4.10/process/coding-style.html).

### Documentation Styleguide

* Use Markdown.
* Keep it simple and stupid.

