#!/usr/bin/env python3
'''Linting tool wrapper'''

import argparse
import os
import re
import subprocess
import sys


def abs_path(rel_path):
  '''Create absolute path from Bazel workspace relative path.'''
  if isinstance(rel_path, str):
    return os.path.join(os.environ['BUILD_WORKSPACE_DIRECTORY'], rel_path)

  return [abs_path(p) for p in rel_path]


def glob_to_regex(globs):
  '''Regex that emulates glob.'''
  regexes = []
  for glob in globs:
    escaped = re.escape(glob)
    escaped = re.sub(r'(\\\*){2,100}/?', '.*', escaped)
    escaped = re.sub(r'\\\*', '[^/]*', escaped)
    regexes.append(escaped)

  return regexes


def glob_to_find_cmd(includes, excludes):
  '''Find command that emulates globs.'''
  # Find common dir that doesn't include a wildcard.
  common_dir = os.path.dirname(os.path.commonprefix(includes + excludes).split('*', maxsplit=1)[0])

  if not common_dir:
    common_dir = '.'

  regex_includes = glob_to_regex(includes)
  regex_excludes = glob_to_regex(excludes)

  prunes = ['(']
  for i, exclude in enumerate(regex_excludes):
    prunes.append('-regex')
    prunes.append(exclude)
    if i < len(regex_excludes) - 1:
      prunes.append('-o')
  prunes += [')', '-prune']

  if len(regex_excludes) == 0:
    prunes = []

  searches = ['(']
  for i, include in enumerate(regex_includes):
    searches.append('-regex')
    searches.append(include)
    if i < len(regex_includes) - 1:
      searches.append('-o')
  searches += [')', '-print']

  if len(regex_includes) == 0:
    searches = []

  find_cmd = []
  if searches:
    find_cmd = ['find', common_dir] + prunes + (['-o'] if prunes else []) + searches

  return find_cmd


def main():
  '''Main function'''
  parser = argparse.ArgumentParser(add_help=False)
  parser.add_argument('--wrapper_tool', required=True)
  parser.add_argument('--wrapper_srcs', nargs='*', default=[])
  parser.add_argument('--wrapper_glob', nargs='*', default=[])
  parser.add_argument('--wrapper_glob_exclude', nargs='*', default=[])
  parser.add_argument('--wrapper_glob_debug', action='store_true')

  known, unknown = parser.parse_known_args()

  find_cmd = glob_to_find_cmd(abs_path(known.wrapper_glob), abs_path(known.wrapper_glob_exclude))

  glob_srcs = []
  if find_cmd:
    ret = subprocess.run(find_cmd, check=True, capture_output=True, text=True)
    glob_srcs = ret.stdout.splitlines()

  srcs = abs_path(known.wrapper_srcs) + glob_srcs

  if known.wrapper_glob_debug:
    print('Glob:')
    for glob in known.wrapper_glob:
      print(f'  {glob}')
    print('')

    print('Glob Exclude:')
    for glob in known.wrapper_glob_exclude:
      print(f'  {glob}')
    print('')

    print(f'Find Command: {" ".join(find_cmd)}')
    print('')

    print('Sources:')
    for src in glob_srcs:
      print(f'  {src}')

    return

  if not srcs:
    raise ValueError(f'No input files. srcs: {known.wrapper_srcs} glob: {known.wrapper_glob} ' +
                     f'glob_exclude: {known.wrapper_glob_exclude}')

  args = [known.wrapper_tool] + unknown + srcs

  ret = subprocess.run(args, check=False)

  sys.exit(ret.returncode)


if __name__ == '__main__':
  main()
