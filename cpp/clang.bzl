load("@bazel_skylib//rules:native_binary.bzl", "native_test")
load("@rules_python//python:defs.bzl", "py_binary")

def clang_format(name, srcs, style_file=None, extra_args=None, visibility=None):
    src_args = ["$(rootpath {})".format(x) for x in srcs]

    if not extra_args:
        extra_args = []

    style_args = []
    if style_file:
        style_args = ["--style=file:$(rootpath {})".format(style_file)]

    native_test(
        name = name + ".test",
        src = "@//cpp:clang-format",
        out = "clang-format_test_copy",
        args = src_args + style_args + extra_args + ["--dry-run", "--Werror"],
        data = srcs + ([style_file] if style_file else []),
        visibility = visibility,
    )

    py_binary(
        name = name + ".fix",
        srcs = ["@//cpp:clang_format_wrapper"],
        main = "clang_format_wrapper.py",
        data = ["@//cpp:clang-format"] + srcs + ([style_file] if style_file else []),
        args = (
            # Signal to wrapper to translate files to workspace directory.
            ["--wrapper_clang_format_path", "$(rootpath @//cpp:clang-format)"] +
            ["--wrapper_workspace_files"] + src_args +
            ["-i"] + style_args + extra_args
        ),
        visibility = visibility,
    )
