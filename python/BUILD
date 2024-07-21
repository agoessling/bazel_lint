load("@rules_python//python:defs.bzl", "py_binary")

py_binary(
    name = "pylint",
    srcs = ["pylint_wrapper.py"],
    main = "pylint_wrapper.py",
    visibility = ["//visibility:public"],
    deps = [
        "@pip//pylint",
    ],
)

py_binary(
    name = "yapf",
    srcs = ["yapf_wrapper.py"],
    main = "yapf_wrapper.py",
    visibility = ["//visibility:public"],
    deps = [
        "@pip//yapf",
    ],
)
