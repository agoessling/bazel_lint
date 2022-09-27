load("@bazel_lint//bazel:buildifier.bzl", "buildifier")
load("@bazel_lint//python:pylint.bzl", "pylint")
load("@bazel_lint//python:yapf.bzl", "yapf")

buildifier(
    name = "format_bazel",
    glob = [
        "**/WORKSPACE",
        "**/*BUILD",
        "**/*.bzl",
    ],
    glob_exclude = [
        "bazel-*/**",
    ],
)

pylint(
    name = "lint_python",
    extra_args = ["--disable=E0401"],
    glob = [
        "**/*.py",
    ],
    glob_exclude = [
        "bazel-*/**",
        "test/**",
    ],
    rcfile = "@bazel_lint//test/python:pylintrc",
)

yapf(
    name = "format_python",
    glob = [
        "**/*.py",
    ],
    glob_exclude = [
        "bazel-*/**",
        "test/**",
    ],
    style_file = "@bazel_lint//test/python:yapfstyle",
)
