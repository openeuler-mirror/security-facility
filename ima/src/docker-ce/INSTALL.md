To install imans patches for docker-ce

1. Clone https://github.com/docker/docker-ce and checkout commit ID 944272e7a144dae50f0846510bc5afb117998747 
2. apply the [patch](./src/0001-xattr-Fix-xattr-preservation-issues.patch)
3. Build and install the custom docker images.

Alternatively, you an replace the docker binaries on the test system with the
binaries (after unzip-ing) in under [bin](./bin/)
