"""First level of dependencies."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

def bazel_lint_first_level_deps():
    """First level of dependencies."""

    # rules_python
    http_archive(
        name = "rules_python",
        sha256 = "b593d13bb43c94ce94b483c2858e53a9b811f6f10e1e0eedc61073bd90e58d9c",
        strip_prefix = "rules_python-0.12.0",
        url = "https://github.com/bazelbuild/rules_python/archive/refs/tags/0.12.0.tar.gz",
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
        build_file = "@bazel_lint//third_party:llvm.BUILD",
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
