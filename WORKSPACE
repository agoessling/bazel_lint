workspace(name = "bazel_lint")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_python",
    sha256 = "9fcf91dbcc31fde6d1edb15f117246d912c33c36f44cf681976bd886538deba6",
    strip_prefix = "rules_python-0.8.0",
    url = "https://github.com/bazelbuild/rules_python/archive/refs/tags/0.8.0.tar.gz",
)

load("@rules_python//python:pip.bzl", "pip_parse")

pip_parse(
   name = "bazel_lint_pip_deps",
   requirements_lock = "@bazel_lint//:requirements_lock.txt",
)

load("@bazel_lint_pip_deps//:requirements.bzl", "install_deps")

install_deps()
