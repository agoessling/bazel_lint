workspace(name = "bazel_lint")

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