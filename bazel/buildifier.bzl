"""Buildifier linting macros."""

load("@//common:lint_tool.bzl", "lint_tool")

def buildifier(
        name,
        srcs = None,
        glob = None,
        glob_exclude = None,
        extra_args = None,
        visibility = None):
    lint_tool(
        name = name,
        tool = "@//bazel:buildifier",
        test_args = ["-lint=warn"],
        fix_args = ["-lint=fix"],
        srcs = srcs,
        glob = glob,
        glob_exclude = glob_exclude,
        extra_args = extra_args,
        visibility = visibility,
    )
