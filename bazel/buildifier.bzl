"""Buildifier linting macros."""

load("@bazel_lint//common:lint_tool.bzl", "lint_tool")

def buildifier(
        name,
        srcs = None,
        glob = None,
        glob_exclude = None,
        extra_args = None,
        visibility = None):
    if not extra_args:
        extra_args = []

    extra_args.append("-diff_command=diff")

    lint_tool(
        name = name,
        tool = "@bazel_lint//bazel:buildifier",
        test_args = ["-mode=diff", "-lint=warn"],
        fix_args = ["-mode=fix", "-lint=fix"],
        srcs = srcs,
        glob = glob,
        glob_exclude = glob_exclude,
        extra_args = extra_args,
        visibility = visibility,
    )
