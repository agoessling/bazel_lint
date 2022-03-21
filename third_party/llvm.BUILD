load("@bazel_skylib//rules:native_binary.bzl", "native_binary")

native_binary(
    name = "clang-tidy",
    src = "bin/clang-tidy",
    out = "clang-tidy-copy",
    visibility = ["//visibility:public"],
)

native_binary(
    name = "clang-format",
    src = "bin/clang-format",
    out = "clang-format-copy",
    visibility = ["//visibility:public"],
)
