# IMA Namespaces

## Goal

The main goal for adding IMA namespace support in kernel is to enable trusted computing in containerized environments.

## Implementation

IMA namespaces isolates IMA resources like IMA Policy, IMA Appraisal Keys, IMA Measurement list from the initial namespace. Hence every container can have its own IMA resources which is isolated from initial/ host namespace. Additionally a new IMA template "ima-ns" is added to include IMA namespace ID. Each container has only access to its own measurement list inside the global measurement list.

## Configuration

### Kernel Configurations

IMA namespace support adds a new CONFIG_IMA_NS option to the kernel configuration, that enables user to create a new IMA namespace. IMA namespace functionality is disabled by default. Enable it along with other kernel configurations mentioned in [IMA Wiki](https://sourceforge.net/p/linux-ima/wiki/Home) for enabling IMA subsystem on host.

### Securityfs Configurations

Additionally few new IMA securityfs entries are added to configure ima namespace:

* Path to the x509 certificate (IMA Appraisal Key):
  * The x509 certificate will be parsed and loaded when the first process is born into the new ima namespace.

* IMA kernel boot parameters (IMA Kernel Parameters):
  * Kernel boot parameters are pre-parsed and applied when the first process is born into the new namespace.

* IMA per namespace Policy:
  * Parse per ima namespace policy file. The path is passed as for the root ima namespace through the ima securityfs 'policy' entry. Optionally, per namespace policy can be passed as boot parameter when the namespace is created.

Reading and validating per namespace measurements.

* IMA violation counter:
  * A new counter is added to 'securityfs' for reporting per namespace violations.

* Per Namespace measurements:
  * User can read the per namespace measurements from ascii_runtime_measurements & binary_runtime_measurements.


## Installation

Enable the Kernel Parameters mentioned in kernel configuration section and rebuild the kernel. Install the newly built kernel image and reboot.

## Testing

Currently we use a custom build docker and runc image to IMA namespace testing. The Docker support for IMA namespace is not complete and it currently uses /etc/docker/daemon.json to pass the IMA configuration parameters to container runtime. Hence it is **not** possible to pass a per-container IMA configuration for individual containers.

**Note: Docker support for IMA Namespace is strictly experimental should be used for only basic validation. We are working on enabling IMA namespace support for iSulad in future.**

### Install and configure custom docker

1. Install docker-engine on openeuler and replace the following binaries with custom build docker binaries from imans-tools repository or rebuild the docker-ce and runc after applying the imans patches.

2. Create an IMA Appraisal Key for the new IMA Namespace.

3. Modify the /etc/docker/daemon.json to reflect the following changes.
```
[root@localhost docker]# cat  /etc/docker/daemon.json
{
  ....
  "default-runtime": "runc",
  "runtimes": {
    "runc-test-runtime": {
      "path": "/path/to/runc",
      "runtimeArgs": [
          "--imans",
          "--ima-x509 /path/to/x509_ima.der",
          "--ima-kcmd \"ima_policy=appraise_tcb ima_template=ima-ns \""
      ]
    }
  },
  ....
}
```
4. Restart the docker daemon.

5. In addtion user should 
   * Bind mount the securityfs inside container,
   * Pass --runtime qualifier to specify the patched runc.
   * Run container with SYS_ADMIN privileges.
   * Run container without default seccomp profile.
   
## Example: Testing IMA Appraisal inside docker containers

1. Start a docker container with the patched runc runtime.

```bash

[root@localhost scripts]# docker run --rm -it --security-opt seccomp=unconfined --mount type=bind,source=/sys/kernel/security/ima,target=/ima --runtime runc-test-runtime --cap-add SYS_ADMIN ima-ubuntu-dev:latest
```

2. Create a tmp file.

```bash
root@fae0cf85d437:~# cat > test.dat
afeaf
^C
```

3. Verify there is no extended attibutes created for the new files.

```bash
root@fae0cf85d437:~# getfattr -m . -d test.dat
root@38108aa515c1:~# exit
```

4. Start the container with ima_appraise=fix ima_policy=appraise_tcb. (remember to restart the docker daemon for the new ima kcmd parameters to take effect. Refer the daemon configuration above)

```bash
[root@localhost scripts]# docker run --rm -it --security-opt seccomp=unconfined --mount type=bind,source=/sys/kernel/security/ima,target=/ima --runtime runc-test-runtime --cap-add SYS_ADMIN ima-ubuntu-dev:latest

root@bd0e43265b82:/# cd ~/
root@bd0e43265b82:~# cat test.dat
afeaf
root@bd0e43265b82:~# getfattr -m . -d ./test.dat
# file: test.dat
security.ima=0sBARIK1sdsPaTIEvx5VfLKL7hdJoXs98B5GW1N/LQUtiR5g==

root@bd0e43265b82:~# exit
```

5. Do a docker commit so that xattr added are persistant accross boot.

6. Start the container after removing ima_appraise=fix kcmd parameter. Verify that security.ima xattr is same as before.

```bash 
root@86028e59f934:/# cd ~/
root@86028e59f934:~# getfattr -m . -d ./test.dat
# file: test.dat
security.ima=0sBARIK1sdsPaTIEvx5VfLKL7hdJoXs98B5GW1N/LQUtiR5g==
```

7. Updating the test.dat file will trigger and IMA appriasal.

```bash
root@86028e59f934:~# cat > ./test.dat
bash: ./test.dat: Permission denied
root@86028e59f934:~# exit
```

8. If needed, user can simulate an offline tampering by booting the container without any ima_kcmd argument to do an offline tampering on the same file. Since IMA is disabled inside the namespace, test.dat will be overwritten.

```bash
root@c43e41d0690f:~# getfattr -m . -d ./test.dat
# file: test.dat
security.ima=0sBARIK1sdsPaTIEvx5VfLKL7hdJoXs98B5GW1N/LQUtiR5g==

root@c43e41d0690f:~# cat > ./test.dat
afadfafa
adfadf
^C
root@c43e41d0690f:~# exit
```

9. Reboot container after adding ima_kcmd "--ima-kcmd \"ima_policy=appraise_tcb ima_template=ima-ns\""

```bash
[root@localhost scripts]# docker run --rm -it --security-opt seccomp=unconfined --mount type=bind,source=/sys/kernel/security/ima,target=/ima --runtime runc-test-runtime --cap-add SYS_ADMIN ima-ubuntu-dev:latest

root@8ddfe0826547:~# cat test.dat
cat: test.dat: Permission denied
```
