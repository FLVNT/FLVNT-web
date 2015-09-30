# encoding: utf-8
"""
  fab.bashrc
  ~~~~~~~~~~

  module with methods to manage the ~/.bashrc file

"""
from __future__ import unicode_literals
from pprint import pformat
from os import environ
from fabric.api import env
from fabric.colors import blue, green, red, yellow
from fabctx import ctx
from contextlib import nested
from fab.environ import get_host
from fab.environ import task
from fab.utils import execute
from fab.utils import puts
from fab import notify


__all__ = ['install']


def install(*args, **kwargs):
  """
  installs bash helpers to the ~/.bashrc file
  """
  puts(blue( "\nsetting up ~/.bashrc file.." ))

  puts(green( " ---> ~/.bashrc file setup.." ))
  notify.terminal('bashrc file setup')
