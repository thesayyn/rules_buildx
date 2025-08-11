"buildx rules"

load("@aspect_bazel_lib//lib:copy_file.bzl", "copy_file")
load("@aspect_bazel_lib//lib:run_binary.bzl", "run_binary")

def buildx(
        name,
        dockerfile,
        path = ".",
        srcs = [],
        build_context = [],
        execution_requirements = {"local": "1"},
        builder_name = "rules_buildx_builder",
        tags = ["manual"],
        visibility = []):
    """
    Run BuildX to produce OCI base image using a Dockerfile.

    Args:
        name: name of the target
        dockerfile: label to the dockerfile to use for this build
        srcs: additional srcs to read during build
        path: path to build context where all will be relative to under Dockerfile
        build_context: a dictionary for custom build contexes. https://docs.docker.com/reference/cli/docker/buildx/build/#build-context
        execution_requirements: execution requirements for the action, we recommend using local as BuildX wants to read files outside of the sandbox.
        builder_name: name of the builder to use. https://docs.docker.com/reference/cli/docker/buildx/build/#builder
        tags: tags for the target
        visibility: visibility for the target
    """
    if "requires-docker" not in tags:
        tags = tags + ["requires-docker"]

    context_args = []
    context_srcs = []
    for context in build_context:
        context_srcs = context_srcs + context["srcs"]
        context_args.append("--build-context={}={}".format(context["replace"], context["store"]))

    copy_file(
        name = name + "_dockerfile",
        src = dockerfile,
        out = "Dockerfile." + name,
        visibility = visibility,
    )

    run_binary(
        name = name,
        srcs = [name + "_dockerfile"] + srcs + context_srcs,
        args = [
            "build",
            path,
            "--file",
            "$(location {}_dockerfile)".format(name),
            "--builder",
            builder_name,
            "--output=type=oci,tar=false,dest=$@",
            # Set the source date epoch to 0 for better reproducibility.
            "--build-arg SOURCE_DATE_EPOCH=0",
        ] + context_args,
        execution_requirements = execution_requirements,
        mnemonic = "BuildX",
        out_dirs = [name],
        tool = "@rules_buildx//buildx:resolved_toolchain",
        tags = tags,
        visibility = visibility,
    )
