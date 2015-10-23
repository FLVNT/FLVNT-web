# encoding: utf-8
"""
  fab.pip
  ~~~~~~~

  fabric for python package manager.

"""
from __future__ import unicode_literals
from pprint import pformat
from fabric.api import env
from fabric.colors import blue, green, red, yellow
from fabctx import ctx
from contextlib import nested
from fab.environ import get_host
from fab.environ import task
from fab.utils import execute
from fab.utils import puts


__all__ = ['update', 'install_requirements']


@task
def update(*args, **kwargs):
  """
  installs python pip requirements
  """
  print(blue("\nupdating pip installs.."))

  with ctx.warn_only():
    execute('pip install -r requirements.txt')

    print(green(" ---> python pip dependencies installed.."))


@task
def install_requirements(*args, **kwargs):
  """
  installs python pip requirements
  """
  print(blue("\ninstalling pip requirements.."))

  with ctx.warn_only():
    execute('pip install -r requirements.txt --upgrade')

  print(green(" ---> python pip requirements installed.."))
