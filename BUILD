load("@bazel_lint//bazel:buildifier.bzl", "buildifier")
load("@rules_python//python:pip.bzl", "compile_pip_requirements")
load("@bazel_lint//python:yapf.bzl", "yapf")

compile_pip_requirements(
    name = "python_requirements",
    extra_args = ["--allow-unsafe"],
    requirements_in = ":requirements.txt",
    requirements_txt = ":requirements_lock.txt",
    tags = ["manual"],
)

filegroup(
    name = "pip_requirements",
    srcs = [
        "requirements.txt",
        "requirements_lock.txt",
    ],
)

buildifier(
    name = "format_bazel",
    glob = [
        "**/WORKSPACE",
        "**/*BUILD",
        "**/*.bzl",
    ],
    glob_exclude = [
        "bazel-*/**",
    ],
)

yapf(
    name = "format_python",
    glob = [
        "**/*.py",
    ],
    glob_exclude = [
        "bazel-*/**",
        "test/**",
    ],
    style_file = "@bazel_lint//test/python:yapfstyle",
)

# This is just the default pylintrc file that comes with pylint i.e.
#   'pylint --generate-rcfile > .pylintrc'
filegroup(
    name = "pylintrc_default",
    srcs = [
        ".pylintrc",
    ],
)

label_flag(
    name = "pylintrc",
    build_setting_default = ":pylintrc_default",
    visibility = ["//visibility:public"],
)
