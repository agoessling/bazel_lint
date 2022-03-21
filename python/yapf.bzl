load("@rules_python//python:defs.bzl", "py_binary", "py_test")

def yapf(name, srcs, style_file=None, extra_args=None, visibility=None):
    if not extra_args:
        extra_args = []

    if style_file:
        extra_args = ["--style", "$(rootpath {})".format(style_file)] + extra_args

    py_test(
        name = name + ".test",
        srcs = ["@//python:yapf"],
        main = "yapf_wrapper.py",
        data = srcs + ([style_file] if style_file else []),
        args = ["--diff"] + ["$(rootpath {})".format(x) for x in srcs] + extra_args,
        visibility = visibility,
        deps = [
            "@//python:yapf",
        ],
    )

    py_binary(
        name = name + ".fix",
        srcs = ["@//python:yapf"],
        main = "yapf_wrapper.py",
        data = srcs + ([style_file] if style_file else []),
        args = (
            # Signal to wrapper to translate files to workspace directory.
            ["--wrapper_workspace_files"] + ["$(rootpath {})".format(x) for x in srcs] +
            ["--in-place"] + extra_args
        ),
        visibility = visibility,
        deps = [
            "@//python:yapf",
        ],
    )
