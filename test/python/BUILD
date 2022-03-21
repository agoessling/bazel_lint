load("@//python:pylint.bzl", "pylint_test")
load("@//python:yapf.bzl", "yapf")

pylint_test(
    name = "lint_python",
    srcs = glob(["**/*.py"], ["bazel-**/*"]),
    rcfile = "pylintrc",
    extra_args = ["--disable=E1120", "--disable=W0613"],
    visibility = ["//visibility:public"],
)

yapf(
    name = "format_python",
    srcs = glob(["**/*.py"], ["bazel-**/*"]),
    style_file = "yapfstyle",
    visibility = ["//visibility:public"],
)
