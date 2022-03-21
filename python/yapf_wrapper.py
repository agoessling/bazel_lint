#!/usr/bin/env python3
'''yapf wrapper'''

import argparse
import os
import sys

import yapf


def main():
  '''Main function'''
  parser = argparse.ArgumentParser(add_help=False)
  parser.add_argument('--wrapper_workspace_files', nargs='+')

  known, unknown = parser.parse_known_args()
  relative_files = known.wrapper_workspace_files

  if not relative_files:
    relative_files = []

  abs_files = [
      os.path.join(os.environ['BUILD_WORKSPACE_DIRECTORY'], x)
      for x in relative_files
  ]

  # Leave script path intact.
  sys.argv[1:] = abs_files + unknown
  yapf.run_main()


if __name__ == '__main__':
  main()
