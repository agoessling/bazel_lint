load("@rules_python//python:defs.bzl", "py_binary")
load("@rules_python//python:pip.bzl", "compile_pip_requirements")

compile_pip_requirements(
    name = "requirements",
    visibility = ["//visibility:public"],
    requirements_in = "requirements.in",
    requirements_txt = "requirements_lock.txt",
    extra_args = ["--allow-unsafe"],
)

py_binary(
    name = "pylint_wrapper",
    srcs = ["pylint_wrapper.py"],
    visibility = ["//visibility:public"],
    deps = [
        "@bazel_lint_pip_deps_pylint//:pkg",
    ],
)
