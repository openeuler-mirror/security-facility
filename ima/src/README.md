# Pull Requests on IMA Digest Lists

## kernel

### kernel-4.19

* **evm: Execute evm_inode_init_security() only when the HMAC key is loaded**

  https://gitee.com/openeuler/kernel/commit/d54555f4a4ed4b50f34eebd8f66b29f7247b52f0

* **evm: Refuse EVM_ALLOW_METADATA_WRITES only if the HMAC key is loaded**

  https://gitee.com/openeuler/kernel/commit/6c7cfed97d2db655f90595d5d921f8f3686d8afe

* **evm: Check size of security.evm before using it**

  https://gitee.com/openeuler/kernel/commit/2bb120184b101d8661fbb9eca05a21bcac58171f

* **evm: Allow xattr/attr operations for portable signatures if check fails**

  https://gitee.com/openeuler/kernel/commit/08937dad1422cce659f438ddd89357e824e1f06d

* **evm: Allow setxattr() and setattr() if metadata digest won't change**

  https://gitee.com/openeuler/kernel/commit/a0fb1c433d6a007d9d81bf0f53552ca4845b0f0f

* **evm: Set IMA_CHANGE_XATTR/ATTR bit if EVM_ALLOW_METADATA_WRITES is set**

  https://gitee.com/openeuler/kernel/commit/ed62c4c21517e1813af847d2b697e76a27dd7b8c

* **ima: Allow imasig requirement to be satisfied by EVM portable signatures**

  https://gitee.com/openeuler/kernel/commit/f792c3ab0c095e44120ed1bbe8d636e2cefa5680

* **ima: Don't remove security.ima if file must not be appraised**

  https://gitee.com/openeuler/kernel/commit/a56155b97af9834dfbd74d7fe9c281c185618c2b

* **ima: Don't ignore errors from crypto_shash_update()**

  https://gitee.com/openeuler/kernel/commit/3e762daba696b7bb979104ba4c7cbfbacc0e5be5

* **ima: Remove semicolon at the end of ima_get_binary_runtime_size()**

  https://gitee.com/openeuler/kernel/commit/83a27507573b4c39f9a98b6dea4d5452d20724a3

* **initramfs: add file metadata**

  https://gitee.com/openeuler/kernel/commit/a10ff8534ccdd051f4a6d33e12811f659ae44db8

* **initramfs: read metadata from special file METADATA!!!**

  https://gitee.com/openeuler/kernel/commit/4d066e6e736c9aa2cc0fa020a850e04a497c0e02

* **gen_init_cpio: add support for file metadata**

  https://gitee.com/openeuler/kernel/commit/460da694ab69f24109003750952f6c679e51ae92

* **init: Add kernel option to force usage of tmpfs for rootfs**

  https://gitee.com/openeuler/kernel/commit/0fff101152e79995eb267b367abca6d6d2f55984

* **ima: Add enforce-evm and log-evm modes to strictly check EVM status**

  https://gitee.com/openeuler/kernel/commit/b2cc097729327867d8391a7bdf3326e1cb8c79dc

* **ima: Allow choice of file hash algorithm for measurement and audit**

  https://gitee.com/openeuler/kernel/commit/2bf814c5f80702b8f871a063478970917eb16168

* **ima: Generalize ima_read_policy()**

  https://gitee.com/openeuler/kernel/commit/19414c2cc2dcf15d70065f398e7df4319e009fee

* **ima: Generalize ima_write_policy() and raise uploaded data size limit**

  https://gitee.com/openeuler/kernel/commit/e4d17869d4e2ad57fe79baacd04055652068e5ed

* **ima: Generalize policy file operations**

  https://gitee.com/openeuler/kernel/commit/13ba53eac258b3508dc2c314eaf5e9cded4600ca

* **ima: Use ima_show_htable_value to show violations and hash table data**

  https://gitee.com/openeuler/kernel/commit/a1e875f71a4417e0cf6cb83936dfa19592b137cc

* **ima: Add parser of compact digest list**

  https://gitee.com/openeuler/kernel/commit/e7277562686cdb277c37cf097d22b8fdcaf2e8e3

* **ima: Prevent usage of digest lists not measured or appraised**

  https://gitee.com/openeuler/kernel/commit/d15a29579f1826ceb3bd4ddf1ca40acf9678559d

* **ima: Introduce new securityfs files**

  https://gitee.com/openeuler/kernel/commit/33264a2077dc891bbf28f28dd523ee076f70d896

* **ima: Introduce new hook DIGEST_LIST_CHECK**

  https://gitee.com/openeuler/kernel/commit/43167d256f4bd7114088706034fa04e092de4117

* **ima: Load all digest lists from a directory at boot time**

  https://gitee.com/openeuler/kernel/commit/d17ce71e298fdaa3691b47da6879fcd846cdeded

* **ima: Add support for measurement with digest lists**

  https://gitee.com/openeuler/kernel/commit/fca204d5efe17660c19006159c7da0a92addcf28

* **ima: Add support for appraisal with digest lists**

  https://gitee.com/openeuler/kernel/commit/e4c279fa121db6aaaad486e232eacfe0be0c19ab

* **evm: Add support for metadata digest lists**

  https://gitee.com/openeuler/kernel/commit/7dce6c8078dba10fc80539a5261a3153af160c84

* **ima: Add meta_immutable appraisal type**

  https://gitee.com/openeuler/kernel/commit/150ae56b9eab22c4ea4d9492341f6ed4bf883c2d

* **ima: Introduce exec_tcb policy**

  https://gitee.com/openeuler/kernel/commit/2f84f8d7b4b46fd9b7b530521d1218f976f6c5a1

* **ima: Introduce appraise_exec_tcb policy**

  https://gitee.com/openeuler/kernel/commit/4f8ac0887f479aafcaeac6324f9cab120745d6a4

* **ima: Introduce appraise_exec_immutable policy**

  https://gitee.com/openeuler/kernel/commit/2d50f4d7307372d00d579792e9f4bc7681b9b28e

* **ima: Add Documentation/security/IMA-digest-lists.txt**

  https://gitee.com/openeuler/kernel/commit/9039533c120d24387599e94ef0732a3b9ed5df9c

* **ima: Use buffer large enough to store fake IMA xattr for appraisal**

  https://gitee.com/openeuler/kernel/commit/bfd38a62dcbcaf0952d408b0c3d26920aa344b2b

* **ima: Require meta_immutable only for BPRM_CHECK hook**

  https://gitee.com/openeuler/kernel/commit/bd2d64eb8df7a0fd17ea3050c7c9cac735f58697

* **ima: Check meta_immutable requirement for every EVM status**

  https://gitee.com/openeuler/kernel/commit/d8bcbc7f0b7690295068e86472411640a8acc639

* **ima: Change fake IMA xattr type to IMA_XATTR_DIGEST_NG**

  https://gitee.com/openeuler/kernel/commit/ecb1c393593a063fd6075c8f3101d0d031ddf42a

* **evm: Reset status even when security.evm is modified**

  https://gitee.com/openeuler/kernel/commit/523feee52209db4d6c8b1482930f018d2ff85d72

* **ima: Display more information in ima_check_measured_appraised()**

  https://gitee.com/openeuler/kernel/commit/4107f92fb427df08360efbcce282b3daf773e5a5

* **ima: Allow appraisal of digest lists without metadata**

  https://gitee.com/openeuler/kernel/commit/1eb11cc39c58078d5b64d5248860825c04d36153

* **evm: Set fake EVM xattr if IMA passed a fake xattr**

  https://gitee.com/openeuler/kernel/commit/1e3f1cfc3d87e5436b58d19b7f9b13977aae4d81

* **mpi: introduce mpi_key_length()**

  https://gitee.com/openeuler/kernel/commit/a06901964688455df90b51d29e0ae204194c1669

* **rsa: add parser of raw format**

  https://gitee.com/openeuler/kernel/commit/4e47bf3ccc169c87bc9b96aced861aa8ffd9e6d5

* **PGPLIB: PGP definitions (RFC 4880)**

  https://gitee.com/openeuler/kernel/commit/6c29e5ad6d1980d5650f144541d22818517bf1f5

* **PGPLIB: Basic packet parser**

  https://gitee.com/openeuler/kernel/commit/c70e5cfa645ea22227b11a1cb30482a7e643ba66

* **KEYS: PGP data parser**

  https://gitee.com/openeuler/kernel/commit/4147c7ccb7c7ac3e3f91b3b54fd5920d7de4b77f

* **KEYS: Provide PGP key description autogeneration**

  https://gitee.com/openeuler/kernel/commit/1f428c50daf2a085e1fce5d3b8da9518e7fc5bb7

* **KEYS: Provide a function to load keys from a PGP keyring blob**

  https://gitee.com/openeuler/kernel/commit/37e754f2f5e9672659d23799bb5802326547b36f

* **KEYS: Introduce load_pgp_public_keyring()**

  https://gitee.com/openeuler/kernel/commit/d9721b5e5645706723d422b73bfc11f0b8ac5145

* **certs: Introduce search_trusted_key()**

  https://gitee.com/openeuler/kernel/commit/386598875880349e01a6efbf73db6427875976b3

* **ima: Search key in the built-in keyrings**

  https://gitee.com/openeuler/kernel/commit/b0db42691d70bc6cc5f296226f94f6430e5d4f98

* **ima: Allow direct upload of digest lists to securityfs**

  https://gitee.com/openeuler/kernel/commit/b5c41de62b431c23da2cda4c699e4fd75efdf93d

* **ima: Add parser keyword to the policy**

  https://gitee.com/openeuler/kernel/commit/7da1170427ca2f0feac12f40c551f1ded60075b2

* **ima: Execute parser to upload digest lists not recognizable by the kernel**

  https://gitee.com/openeuler/kernel/commit/56454adb279b12c5b878a1b2fb7d4c475f028638

* **evm: Extend evm= with x509 and allow_metadata_writes values**

  https://gitee.com/openeuler/kernel/commit/4f79e42030839867d7e5bb7fe6190be336022ff3

* **config: Add digest lists options for x86**

  https://gitee.com/openeuler/kernel/commit/522baaf870e62d99fefe9e81d1b62d4305d482f9

* **configs: update configs introduced by ima enhance**

  https://gitee.com/openeuler/kernel/commit/17d07479bc04bdece3d4a97cd23d16ce16b37d99

* **evm: Move hooks outside LSM infrastructure**

  https://gitee.com/openeuler/kernel/commit/ab8841090a6488502a0dade9cea9e9db4d78d9ed

* **evm: Extend API of post hooks to pass the result of pre hooks**

  https://gitee.com/openeuler/kernel/commit/dcf1b463aa70d0c44c4bcfc6f442fe431f7ad4f0

* **evm: Return -EAGAIN to ignore verification failures**

  https://gitee.com/openeuler/kernel/commit/a5726544fc2f923404d118208d1ec7e1299c2945

* **evm: Propagate choice of HMAC algorithm in evm_crypto.c**

  https://gitee.com/openeuler/kernel/commit/1bc1a8be6287def856f85c86b99d82fbe955397e

* **ima: Fix datalen check in ima_write_data()**

  https://gitee.com/openeuler/kernel/commit/4486f6922fc107837c7794c2e39ecdd1b971c225

* **evm: Fix validation of fake xattr passed by IMA**

  https://gitee.com/openeuler/kernel/commit/174c9c6b3f9691f66ccc2c5b16f007dfa9d39232

* **evm: Initialize saved_evm_status**

  https://gitee.com/openeuler/kernel/commit/07dd1dfc870b5eccb2259f38737b52fc43328938

* **config: add digest list options for arm64**

  https://gitee.com/openeuler/kernel/commit/dff4d06b8e6d370c344887bab3c11401c2206520

## related packages

### digest-list-tools

**upstream**: https://gitee.com/openeuler/digest-list-tools

### attest-tools

**upstream**: https://gitee.com/openeuler/attest-tools

### pesign-obs-integration

* **initial version**

  https://gitee.com/src-openeuler/pesign-obs-integration/commit/795e3b1989504a7013aaab4db79748a1f7e2d787

### tss2

* **Initial import**

  https://gitee.com/src-openeuler/tss2/commit/0e5023f194f19d192fed9fbf8072f8e67f5becab

* **Switch to version 1470**

  https://gitee.com/src-openeuler/tss2/commit/cf8d0b518a918924c793c9ce9b3faf7cf31b3f3b

### ima-evm-utils

* **add save command and support IMA digest list**

  https://gitee.com/src-openeuler/ima-evm-utils/commit/e5cd1f25a0c45b97eb577f14f6e02e6df48a0a75

### cpio

* **add option to add file metadata in copy-out mode**

  https://gitee.com/src-openeuler/cpio/commit/864ca580eb707dcc10da71f41951eb73805d4dfb

* **fix use after free and return appropriate errors**

  https://gitee.com/src-openeuler/cpio/commit/4b48c4e23f697a749358a985cb085763af89fe94

### dracut

* **add -e option to include file metadata in initramfs**

  https://gitee.com/src-openeuler/dracut/commit/1aaf08abe665a662d508c96e2572b8a4ddb45640

### rpm

* **Add digest list patches**

  https://gitee.com/src-openeuler/rpm/commit/8740452fb2459ab7e6103bc90b09915360c076da

* **Replace security.evm with security.ima in digest list plugin**

  https://gitee.com/src-openeuler/rpm/commit/d85b3deb27873ae52eb3da99260075d88a294d79

* **Don't add dist to release if it is already there**

  https://gitee.com/src-openeuler/rpm/commit/aca04b8503675f666148f6a5eca611cf34d80ba9

* **Don't process parser digest list if it is not signed**

  https://gitee.com/src-openeuler/rpm/commit/4c6fa874b6aadb42ce31004c6d0b6fcc67e3010f

* **Remove old rpm digest list**

  https://gitee.com/src-openeuler/rpm/commit/4b81801d7ee98c6b10a13429adeb2a41bdd3cf11

* **Use user.digest_list to avoid duplicate processing of the digest lists**

  https://gitee.com/src-openeuler/rpm/commit/ab93d5475d21208a55ab3c27be5438ff31d09558

* **call process_digest_list before files are added**

  https://gitee.com/src-openeuler/rpm/commit/cf56b2ddae7b0ef98f26585b73ed23ba400bbe91

### openEuler-rpm-config

* **add brp-digest-list**

  https://gitee.com/src-openeuler/openEuler-rpm-config/commit/e7aee4f7cdc24be41a74084bd7d09624d29f1405

### firewalld

* **create firewalld temporary file in spec**

  https://gitee.com/src-openeuler/firewalld/commit/32b21583c8dc966a900a0dd3a25f2b9e50400d9e

### selinux-policy

* **fix selinux label for hostname digest list**

  https://gitee.com/src-openeuler/selinux-policy/commit/8ad71f4dc61f4ea22f6220d332f022d8451de6a4

* **add file context for firewalld temporary file**

  https://gitee.com/src-openeuler/selinux-policy/commit/3a0f999a8132764ec9c846681ee3a261991b3d00

### plymouth

* **carry xattr when copying files to initramfs**

  https://gitee.com/src-openeuler/plymouth/commit/878585646d5d420b84e5c26f95e93278de5c7ae7