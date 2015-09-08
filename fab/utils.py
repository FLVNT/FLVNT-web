# encoding: utf-8
"""
  fab.utils
  ~~~~~~~~~

  general helper methods + utils.

"""
from __future__ import unicode_literals
from functools import wraps
from fabric.api import env
from fabric.api import run, cd
from fabric.api import local
from fabric.colors import blue, green, red, yellow
from fabctx import ctx, virtualenv
from fab import environ, nvm


__all__ = [
  'execute', 'env_context', 'approot', 'print_command', 'log_call',
  'ensure_remote_host', 'ensure_test_environ',
]


def execute(command, *args, **kwargs):
  """
  intelligently execute a command for the target host env.
  """
  if env.env_id in ('local', 'test'):
    return local(command, *args, **kwargs)
  else:
    with env_context(environ.get_host()):
      return run(command, *args, **kwargs)


@ctx.contextmanager
def env_context(host):
  """
  function wrapper to run a task on a remote host, setting the shell context
  with the python-virtualenv and nvm-node-versions.
  """
  with shell_env_id():
    with virtualenv.workon(host['workon']):
      with nvm.nvm_use(host['node_version']):
        with approot(host):
          yield


@ctx.contextmanager
def shell_env_id():
  with ctx.shell_env(ENV_ID=env.env_id):
    yield


@ctx.contextmanager
def approot(host):
  """
  method decorator to run a command from the application root dir.
  """
  with cd(host['root']):
    yield


# debug tools + helpers..
# -----------------------------------------------------------------------------

def print_command(command):
  """
  prints a command string
  """
  print("{} {}\n{}".format(
    blue("$ ", bold=True), blue(command, bold=True), red(" --->"),
  ))


def log_call(func):
  """
  method decorator to trace function calls.
  """
  @wraps(func)
  def logged(*args, **kawrgs):
    header = "-" * len(func.__name__)
    print(yellow("\n -> ".join([header, func.__name__, header]), bold=True))
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
