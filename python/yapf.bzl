"""Yapf formatting macros."""

load("@//common:lint_tool.bzl", "lint_tool")

def yapf(
        name,
        srcs = None,
        glob = None,
        glob_exclude = None,
        style_file = None,
        extra_args = None,
        visibility = None):
    """Yapf formatting tool

    Args:
      name: Base name of package.
      srcs: Sources to be passed to formatter.
      glob: Globs to be passed to formatter.
      glob_exclude: Globs to be excluded from "srcs" and "glob".
      style_file: Yapf style file.
      extra_args: Extra arguments to pass to formatter.
      visibility: Visibility of targets."""

    style_args = []
    if style_file:
        style_args = ["--style", "$(rootpath {})".format(style_file)]

    if not extra_args:
        extra_args = []

    lint_tool(
        name = name,
        tool = "@//python:yapf",
        test_args = ["--diff"],
        fix_args = ["--in-place"],
        srcs = srcs,
        glob = glob,
        glob_exclude = glob_exclude,
        extra_args = style_args + extra_args,
        data = [style_file] if style_file else [],
        visibility = visibility,
    )
