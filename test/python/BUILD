load("@bazel_lint//python:yapf.bzl", "yapf")

exports_files([
    "yapfstyle",
])

yapf(
    name = "format_python",
    glob = [
        "**/*.py",
    ],
    glob_exclude = [
        "bazel-**/*",
    ],
    style_file = "yapfstyle",
    visibility = ["//visibility:public"],
)
