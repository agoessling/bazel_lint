load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")
load("@rules_python//python:pip.bzl", "pip_install")

def bazel_lint_second_level_deps():
    pip_install(
       name = "bazel_lint_py_deps",
       requirements = "@//:requirements.txt",
    )

    bazel_skylib_workspace()

    rules_foreign_cc_dependencies()
