load("@bazel_lint_py_deps//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_binary")


py_binary(
    name = "pylint",
    srcs = ["pylint_wrapper.py"],
    main = "pylint_wrapper.py",
    visibility = ["//visibility:public"],
    deps = [
        requirement("pylint"),
        requirement("tomli"),
    ],
)

py_binary(
    name = "yapf",
    srcs = ["yapf_wrapper.py"],
    main = "yapf_wrapper.py",
    visibility = ["//visibility:public"],
    deps = [
        requirement("yapf"),
    ],
)
