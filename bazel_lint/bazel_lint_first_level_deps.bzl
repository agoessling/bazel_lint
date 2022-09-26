"""First level of dependencies."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

def bazel_lint_first_level_deps():
    """First level of dependencies."""

    # rules_python
    http_archive(
        name = "rules_python",
        sha256 = "9fcf91dbcc31fde6d1edb15f117246d912c33c36f44cf681976bd886538deba6",
        strip_prefix = "rules_python-0.8.0",
        url = "https://github.com/bazelbuild/rules_python/archive/refs/tags/0.8.0.tar.gz",
    )

    # skylib
    http_archive(
        name = "bazel_skylib",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
        ],
        sha256 = "74d544d96f4a5bb630d465ca8bbcfe231e3594e5aae57e1edbf17a6eb3ca2506",
    )

    # llvm
    http_archive(
        name = "llvm",
        build_file = "@//third_party:llvm.BUILD",
        sha256 = "ad0f6eb12ecdfbdb61105e4fefbc2b16b90fb8a04248097acb7d2fe00ec4694d",
        strip_prefix = "clang+llvm-14.0.6-x86_64-ubuntu-22.04",
        url = "https://github.com/awakecoding/llvm-prebuilt/releases/download/v2022.2.0/clang+llvm-14.0.6-x86_64-ubuntu-22.04.tar.xz",
    )

    # buildifier
    http_file(
        name = "buildifier",
        sha256 = "52bf6b102cb4f88464e197caac06d69793fa2b05f5ad50a7e7bf6fbd656648a3",
        urls = ["https://github.com/bazelbuild/buildtools/releases/download/5.1.0/buildifier-linux-amd64"],
        executable = True,
    )
