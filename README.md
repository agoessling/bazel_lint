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

load("@bazel_lint//bazel_lint:deps.bzl", "download_http_archives")

download_http_archives()

load("@rules_python//python:repositories.bzl", "py_repositories", "python_register_toolchains")

py_repositories()

python_register_toolchains(
    name = "python3_11",
    # Available versions are listed in @rules_python//python:versions.bzl.
    # We recommend using the same version your team is already standardized on.
    python_version = "3.11",
)

load("@rules_python//python:pip.bzl", "pip_parse")

# Create a central repo that knows about the dependencies needed from
# requirements_lock.txt.
pip_parse(
    name = "bazel_lint_py_deps",
    requirements_lock = "//:requirements_lock.txt",
)

# Load the starlark macro which will define your dependencies.
load("@bazel_lint_py_deps//:requirements.bzl", "install_deps")

# Call it to define repos for your requirements.
install_deps()
```

### Pylint

To run pylint on the entire directory you can use the following invocation.

```
bazel build //... \
  --aspects @bazel_lint//python:pylint.bzl%pylint_aspect \
  --output_groups=report
```

Ergonomics can be improved by making the following config in your .bazelrc.


```py
build:pylint --aspects @bazel_lint//python:pylint.bzl%pylint_aspect
build:pylint --output_groups=report
```

Then pylint can be run with:

```
bazel build --config pylint //...
```


If you would like to override the default pylintrc make a filegroup in your root BUILD
file.

```py
# //:BUILD
filegroup(
       name = "pylintrc",
       srcs = [".pylintrc"],
       visibility = ["//visibility:public"],
)
```

Now you can override the default config file in this repository by modifying
your .bazelrc.

```
build:pylint --aspects @bazel_lint//python:pylint.bzl%pylint_aspect
build:pylint --output_groups=report
build:pylint --@bazel_lint//:pylintrc=//:pylintrc
```
