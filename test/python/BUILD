load("@//python:pylint.bzl", "pylint")
load("@//python:yapf.bzl", "yapf")

exports_files([
    "pylintrc",
    "yapfstyle",
])

pylint(
    name = "lint_python",
    glob = [
        "**/*.py",
    ],
    glob_exclude = [
        "bazel-**/*",
    ],
    rcfile = "pylintrc",
    visibility = ["//visibility:public"],
)

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
