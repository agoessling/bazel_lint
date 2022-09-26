load("@//bazel:buildifier.bzl", "buildifier")
load("@//python:pylint.bzl", "pylint")
load("@//python:yapf.bzl", "yapf")

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
    rcfile = "@//test/python:pylintrc",
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
    style_file = "@//test/python:yapfstyle",
)
