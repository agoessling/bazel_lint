"""Clang linting macros."""

load("@bazel_lint//common:lint_tool.bzl", "lint_tool")

def clang_format(
        name,
        srcs = None,
        glob = None,
        glob_exclude = None,
        style_file = None,
        extra_args = None,
        visibility = None):
    """Clang formatting tool

    Args:
      name: Base name of package.
      srcs: Sources to be passed to formatter.
      glob: Globs to be passed to formatter.
      glob_exclude: Globs to be excluded from "srcs" and "glob".
      style_file: Clang-format style file.
      extra_args: Extra arguments to pass to formatter.
      visibility: Visibility of targets."""

    style_args = []
    if style_file:
        style_args = ["--style=file:$(rootpath {})".format(style_file)]

    if not extra_args:
        extra_args = []

    lint_tool(
        name = name,
        tool = "@bazel_lint//cpp:clang-format",
        test_args = ["--dry-run", "--Werror"],
        fix_args = ["-i"],
        srcs = srcs,
        glob = glob,
        glob_exclude = glob_exclude,
        extra_args = style_args + extra_args,
        data = [style_file] if style_file else [],
        visibility = visibility,
    )
