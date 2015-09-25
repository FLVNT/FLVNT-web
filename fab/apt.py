# encoding: utf-8
"""
  fab.apt
  ~~~~~~~

  context for apt.

"""
from __future__ import unicode_literals
from fab.environ import task
from fabric.api import sudo as _sudo
from fabric.api import hide
from fab.utils import print_command, log_call


@task
def apt(packages):
  """
  installs one or more system packages via apt.
  """
  return sudo("apt-get install -y -q " + packages)


@task
def sudo(command, show=True, *args, **kwargs):
  """
  runs a command as sudo on the remote server.
  """
  if show:
    print_command(command)
  with hide("running"):
    return _sudo(command, *args, **kwargs)
