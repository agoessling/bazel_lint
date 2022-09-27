load("@bazel_lint//cpp:clang.bzl", "clang_format")

clang_format(
    name = "format_cc",
    srcs = glob([
        "**/*.cc",
        "**/*.h",
    ]),
    style_file = ".clang-format",
    visibility = ["//visibility:public"],
)
