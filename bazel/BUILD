load("@bazel_skylib//rules:native_binary.bzl", "native_binary")
load("@rules_python//python:defs.bzl", "py_binary")

native_binary(
    name = "buildifier",
    src = "@buildifier//file",
    out = "buildifier_copy",
    visibility = ["//visibility:public"],
)

py_binary(
    name = "clang_format_wrapper",
    srcs = ["clang_format_wrapper.py"],
    visibility = ["//visibility:public"],
)
