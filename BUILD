load("@bazel_lint//bazel:buildifier.bzl", "buildifier")
load("@bazel_lint//python:pylint.bzl", "pylint")
load("@bazel_lint//python:yapf.bzl", "yapf")
load("@rules_python//python:pip.bzl", "compile_pip_requirements")

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

compile_pip_requirements(
    name = "requirements",
    extra_args = ["--allow-unsafe"],
    requirements_in = "requirements.txt",
    requirements_txt = "requirements_lock.txt",
)
