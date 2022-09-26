load("@bazel_skylib//rules:native_binary.bzl", "native_test")
load("@rules_python//python:defs.bzl", "py_binary")

def buildifier(name, srcs, extra_args = None, visibility = None):
    src_args = ["$(rootpath {})".format(x) for x in srcs]

    if not extra_args:
        extra_args = []

    print(srcs)

    native_test(
        name = name + ".test",
        src = "@//bazel:buildifier",
        out = "buildifier_test_copy",
        args = ["-lint=warn"] + extra_args + src_args,
        data = srcs,
        visibility = visibility,
    )

    py_binary(
        name = name + ".fix",
        srcs = ["@//bazel:buildifier_wrapper"],
        main = "buildifier_wrapper.py",
        data = ["@//bazel:buildifier"] + srcs,
        args = (
            # Signal to wrapper to translate files to workspace directory.
            ["--wrapper_buildifier_path", "$(rootpath @//bazel:buildifier)"] +
            ["--wrapper_workspace_files"] + src_args +
            ["-lint=fix"] + extra_args
        ),
        visibility = visibility,
    )
