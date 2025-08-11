# Bazel rules for BuildX

Bazel rules for https://github.com/docker/buildx.

This ruleset aims to provide means for building Dockerfiles under Bazel. [^1]

# Requirements

- Functioning Docker runtime required to be installed on the execution environment. [^2]
- Actions must[^4] have access to network.

[^1]: Not well suited for containerized RBE environments, due to Docker-in-Docker sutiation.
[^2]: A hard dependency on Docker runtime [^3] is introduced.
[^3]: BuildX does not work with other container runtimes such as podman.
[^4]: rules_buildx has some builtin mechanisms for offline builds. (requires configuration)

## Installation

From the release you wish to use:
<https://github.com/thesayyn/rules_buildx/releases>
copy the WORKSPACE snippet into your `WORKSPACE` file.

# Resources

- https://reproducible-builds.org/
- https://github.com/bazel-contrib/rules_oci/issues/35#issuecomment-1285954483
- https://github.com/bazel-contrib/rules_oci/blob/main/docs/compare_dockerfile.md
- https://github.com/moby/moby/issues/43124
- https://github.com/moby/buildkit/blob/master/docs/build-repro.md
- https://medium.com/nttlabs/bit-for-bit-reproducible-builds-with-dockerfile-7cc2b9faed9f
