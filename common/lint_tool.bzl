"""Base linting macro."""

load("@bazel_skylib//lib:paths.bzl", "paths")
load("@rules_python//python:defs.bzl", "py_binary")

def lint_tool(
        name,
        tool,
        test_args,
        fix_args,
        srcs = None,
        glob = None,
        glob_exclude = None,
        extra_args = None,
        data = None,
        visibility = None):
    """Generic linting tool passes globs to lint_wrapper.py

    Creates a "name.test" and "name.fix" targets with corresponding arguments from test_args and
    fix_args

    Args:
      name: Base name of package.
      tool: Underlying tool to be called.
      test_args: Test specific args.
      fix_args: Fix specific args.
      srcs: Sources to be passed to linter.
      glob: Globs to be passed to linter.
      glob_exclude: Globs to be excluded from "srcs" and "glob".
      extra_args: Extra arguments to pass to linter,
      data: Data files to be made available to linter,
      visibility: Visibility of targets."""

    if not srcs:
        srcs = []

    if not glob:
        glob = []

    if not glob_exclude:
        glob_exclude = []

    if not extra_args:
        extra_args = []

    if not data:
        data = []

    src_args = ["$(rootpath {})".format(x) for x in srcs]
    glob_args = [paths.join(native.package_name(), g) for g in glob]
    glob_exclude_args = [paths.join(native.package_name(), g) for g in glob_exclude]

    py_binary(
        name = name + ".test",
        srcs = ["@bazel_lint//common:tool_wrapper"],
        main = "tool_wrapper.py",
        data = data + [tool] + srcs,
        args = (
            ["--wrapper_tool", "$(rootpath {})".format(tool)] +
            test_args + extra_args +
            ["--wrapper_srcs"] + src_args +
            ["--wrapper_glob"] + glob_args +
            ["--wrapper_glob_exclude"] + glob_exclude_args
        ),
        visibility = visibility,
    )

    py_binary(
        name = name + ".fix",
        srcs = ["@bazel_lint//common:tool_wrapper"],
        main = "tool_wrapper.py",
        data = data + [tool] + srcs,
        args = (
            ["--wrapper_tool", "$(rootpath {})".format(tool)] +
            fix_args + extra_args +
            ["--wrapper_srcs"] + src_args +
            ["--wrapper_glob"] + glob_args +
            ["--wrapper_glob_exclude"] + glob_exclude_args
        ),
        visibility = visibility,
    )
