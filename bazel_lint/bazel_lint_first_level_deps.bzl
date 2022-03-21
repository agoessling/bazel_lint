load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def bazel_lint_first_level_deps():
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

    # rules_foreign_cc
    http_archive(
	name = "rules_foreign_cc",
	sha256 = "2a4d07cd64b0719b39a7c12218a3e507672b82a97b98c6a89d38565894cf7c51",
	strip_prefix = "rules_foreign_cc-0.9.0",
	url = "https://github.com/bazelbuild/rules_foreign_cc/archive/refs/tags/0.9.0.tar.gz",
    )

    # llvm
    http_archive(
        name = "llvm",
	build_file = "@//third_party:llvm.BUILD",
        sha256 = "ad0f6eb12ecdfbdb61105e4fefbc2b16b90fb8a04248097acb7d2fe00ec4694d",
        strip_prefix = "clang+llvm-14.0.6-x86_64-ubuntu-22.04",
        url = "https://github.com/awakecoding/llvm-prebuilt/releases/download/v2022.2.0/clang+llvm-14.0.6-x86_64-ubuntu-22.04.tar.xz",
    )
