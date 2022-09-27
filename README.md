# bazel_lint

Provide linting tools and rules / macros in [Bazel](https://bazel.build/).

Currently the following tools and rules are provide (for Linux):
* [buildifier](https://github.com/bazelbuild/buildtools/tree/master/buildifier)
* [yapf](https://github.com/google/yapf)
* [pylint](https://pylint.pycqa.org/en/latest/)
* [clang-format](https://clang.llvm.org/docs/ClangFormat.html)

## Usage

### WORKSPACE

To incorporate `bazel_lint` into your project copy the following into your `WORKSPACE` file.

```Starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_lint",
    # See release page for latest version url and sha.
)

load("@bazel_lint//:bazel_lint_first_level_deps.bzl", "bazel_lint_first_level_deps")
bazel_lint_first_level_deps()

load("@bazel_lint//:bazel_lint_second_level_deps.bzl", "bazel_lint_second_level_deps")
bazel_lint_second_level_deps()
```
