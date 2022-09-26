#!/usr/bin/env python3
'''Linting tool wrapper'''

import argparse
import glob
import os
import subprocess
import sys


def abs_path(rel_path):
  '''Create absolute path from Bazel workspace relative path.'''
  if isinstance(rel_path, str):
    return os.path.join(os.environ['BUILD_WORKSPACE_DIRECTORY'], rel_path)

  return [abs_path(p) for p in rel_path]


def main():
  '''Main function'''
  parser = argparse.ArgumentParser(add_help=False)
  parser.add_argument('--wrapper_tool', required=True)
  parser.add_argument('--wrapper_srcs', nargs='*')
  parser.add_argument('--wrapper_glob', nargs='*')
  parser.add_argument('--wrapper_glob_exclude', nargs='*')

  known, unknown = parser.parse_known_args()

  srcs = set()

  if known.wrapper_srcs:
    srcs |= set(abs_path(known.wrapper_srcs))

  if known.wrapper_glob:
    for x in abs_path(known.wrapper_glob):
      srcs |= set(glob.glob(x, recursive=True))

  if known.wrapper_glob_exclude:
    for x in abs_path(known.wrapper_glob_exclude):
      srcs -= set(glob.glob(x, recursive=True))

  if not srcs:
    raise ValueError(
        f'No input files. srcs: {known.wrapper_srcs} glob: {known.wrapper_glob} '
        + f'glob_exclude: {known.wrapper_glob_exclude}')

  args = [known.wrapper_tool] + unknown + list(srcs)

  ret = subprocess.run(args, check=False)

  sys.exit(ret.returncode)


if __name__ == '__main__':
  main()
