#!/usr/bin/env python3
'''buildifier wrapper'''

import argparse
import os
import subprocess
import sys


def main():
  '''Main function'''
  parser = argparse.ArgumentParser(add_help=False)
  parser.add_argument('--wrapper_buildifier_path', required=True)
  parser.add_argument('--wrapper_workspace_files', nargs='+')

  known, unknown = parser.parse_known_args()
  buildifier_path = known.wrapper_buildifier_path
  relative_files = known.wrapper_workspace_files

  if not relative_files:
    relative_files = []

  abs_files = [
      os.path.join(os.environ['BUILD_WORKSPACE_DIRECTORY'], x)
      for x in relative_files
  ]

  args = [buildifier_path] + abs_files + unknown

  ret = subprocess.run(args)

  sys.exit(ret.returncode)


if __name__ == '__main__':
  main()
