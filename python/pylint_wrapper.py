#!/usr/bin/env python3
"""Wrapper around pylint."""

from pathlib import Path
import sys
from typing import List
import pylint

def split_args(args):
    """Split the arguments by --bazel-imports."""
    index = args.index("--bazel-imports")
    return args[:index], args[index + 1 :]


def import_bazel_deps(bazel_imports: List[str]):
    """Import all the deps from the bazel imports."""
    # The first bin directory is the one that contains the first party deps.
    bin_dir = list(Path("./").rglob("**/bin"))[0]

    # Add the imports to the system path.
    for path in bazel_imports:
        if path.startswith("_main"):
            path = path.replace("_main", str(bin_dir))
        else:
            path = f"external/{path}"
        sys.path.append(path)

# Split the arguments by --bazel-imports.
pylint_args, bazel_imports= split_args(sys.argv)

# Import all the deps from the bazel imports.
import_bazel_deps(bazel_imports)

# Import the current directory to get the first party deps.
sys.path.append(".")
sys.path.append("external")

# Remove the arguments that are not meant for pylint.
sys.argv = sys.argv[:5]


if __name__ == "__main__":
    pylint.run_pylint()
