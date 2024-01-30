"""Workspace http archive dependencies."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

def download_http_archives():
    """Download all http archives."""

    # rules_python
    http_archive(
        name = "rules_python",
        sha256 = "e85ae30de33625a63eca7fc40a94fea845e641888e52f32b6beea91e8b1b2793",
        strip_prefix = "rules_python-0.27.1",
        url = "https://github.com/bazelbuild/rules_python/releases/download/0.27.1/rules_python-0.27.1.tar.gz",
    )

    # skylib
    http_archive(
        name = "bazel_skylib",
        sha256 = "cd55a062e763b9349921f0f5db8c3933288dc8ba4f76dd9416aac68acee3cb94",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.5.0/bazel-skylib-1.5.0.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.5.0/bazel-skylib-1.5.0.tar.gz",
        ],
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
