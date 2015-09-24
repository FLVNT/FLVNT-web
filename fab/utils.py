# encoding: utf-8
"""
  fab.utils
  ~~~~~~~~~

  general helper methods + utils.

"""
from __future__ import unicode_literals
from pprint import pformat
from functools import wraps
from fabric.api import env
from fabric.api import run, cd
from fabric.api import local
from fabric.colors import blue, green, red, yellow
from fabctx import ctx, virtualenv
from contextlib import nested
from fabric.utils import puts


__all__ = ['execute', 'print_command', 'log_call',
'ensure_remote_host', 'ensure_test_environ', 'puts', 'log_call', 'print_command']


def execute(command, *args, **kwargs):
  """
  intelligently execute a command for the target host env.
  """
  capture = kwargs.pop('capture', True)
  # debug   = kwargs.pop('debug', True)
  if env.env_id in ('local', 'test'):
    return local(command, capture=capture, *args, **kwargs)

  else:
    from fab import environ
    with environ.prefix_host_shell():
      return run(command, *args, **kwargs)


# debug tools + helpers..
# -----------------------------------------------------------------------------

def print_command(command):
  """
  prints a command string
  """
  puts("{} {}\n{}".format(
    blue("$ ", bold=True), blue(command, bold=True), red(" --->"),
  ))


def log_call(func):
  """
  method decorator to trace function calls.
  """
  @wraps(func)
  def logged(*args, **kawrgs):
    header = "-" * len(func.__name__)
    puts(yellow("\n -> ".join([header, func.__name__, header]), bold=True))
    return func(*args, **kawrgs)
  return logged


# ssh / remote helpers
# -----------------------------------------------------------------------------

def ensure_remote_host():
  """
  only allow commands to be executed in remote environments.
  """
  if env.env_id in ('local', 'test'):
    raise Exception('can only run command within a remote environment.')


def ensure_test_environ():
  """
  only allow commands to be executed in test environment.
  """
  if env.env_id not in ('test',):
    raise Exception('can only run command for `test` environment.')



from functools import wraps


def _print(output):
  print()
  print(output)
  print()


def print_command(command):
  _print("{}{}{}".format(
    blue("$ ", bold=True), yellow(command, bold=True), red(" ->", bold=True)))


def log_call(func):
  @wraps(func)
  def logged(*args, **kawrgs):
    header = "-" * len(func.__name__)
    _print(green("\n".join([header, func.__name__, header]), bold=True))
    return func(*args, **kawrgs)
  return logged

