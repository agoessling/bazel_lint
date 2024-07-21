"""Third level of dependencies."""

load("@bazel_lint_py_deps//:requirements.bzl", "install_deps")

def bazel_lint_third_level_deps():
    """Third level of dependencies."""
    install_deps()
