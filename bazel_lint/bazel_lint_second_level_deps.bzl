"""Second level of dependencies."""

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
load("@rules_python//python:pip.bzl", "pip_parse")

def bazel_lint_second_level_deps():
    """Second level of dependencies."""
    pip_parse(
        name = "bazel_lint_py_deps",
        requirements_lock = "@bazel_lint//:requirements_lock.txt",
    )

    bazel_skylib_workspace()
