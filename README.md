# bazel_lint

Provide linting tools and rules / macros in [Bazel](https://bazel.build/).

Currently the following tools and rules are provide (for Linux):
* [buildifier](https://github.com/bazelbuild/buildtools/tree/master/buildifier)
* [yapf](https://github.com/google/yapf)
* [pylint](https://pylint.pycqa.org/en/latest/)
* [clang-format](https://clang.llvm.org/docs/ClangFormat.html)

## Usage

### MODULE.bazel

To incorporate `bazel_lint` into your project copy the following into your `MODULE.bazel` file.
NOTE: See older releases for `WORKSPACE` compatibility.

```Starlark
bazel_dep(name = "bazel_lint", version = "0.2.0")
```
