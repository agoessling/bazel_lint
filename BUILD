load("@//bazel:buildifier.bzl", "buildifier")

buildifier(
    name = "format_bazel",
    srcs = glob(
        [
            "**/WORKSPACE",
            "**/*BUILD",
            "**/buildifier.bzl",
            "**/*.h",
        ],
        [
            "bazel-*/**",
        ],
    ),
    visibility = ["//visibility:public"],
)
