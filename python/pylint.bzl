"""Pylint linting macros."""

load("@bazel_lint//common:lint_tool.bzl", "lint_tool")

def pylint(
        name,
        srcs = None,
        glob = None,
        glob_exclude = None,
        rcfile = None,
        extra_args = None,
        visibility = None):
    """Pylint linting tool

    Args:
      name: Base name of package.
      srcs: Sources to be passed to linter.
      glob: Globs to be passed to linter.
      glob_exclude: Globs to be excluded from "srcs" and "glob".
      rcfile: Pylint RC file.
      extra_args: Extra arguments to pass to linter.
      visibility: Visibility of targets."""

    rc_args = []
    if rcfile:
        rc_args = ["--rcfile", "$(rootpath {})".format(rcfile)]

    if not extra_args:
        extra_args = []

    extra_args.append("-j0")

    lint_tool(
        name = name,
        tool = "@bazel_lint//python:pylint",
        test_args = [],
        fix_args = [],
        srcs = srcs,
        glob = glob,
        glob_exclude = glob_exclude,
        extra_args = rc_args + extra_args,
        data = [rcfile] if rcfile else [],
        visibility = visibility,
    )
