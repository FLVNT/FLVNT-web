# encoding: utf-8
"""
  fab.pip
  ~~~~~~~

  fabric context for python package manager.

"""
from __future__ import unicode_literals
from pprint import pformat
from fabric.api import env
from fabric.colors import blue, green, red, yellow
from fabctx import ctx
from fab.environ import get_host
from fab.environ import task
from fab.utils import execute


__all__ = ['update']


@task
def update(*args, **kwargs):
  """
  installs python pip requirements
  """
  print(blue("updating pip installs.."))

  with ctx.warn_only():
    execute('pip install -r requirements.txt')

    print(green(" ---> pip python dependencies installed.."))
