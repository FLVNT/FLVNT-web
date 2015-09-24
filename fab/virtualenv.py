# encoding: utf-8
"""
  fab.virtualenv
  ~~~~~~~~~~~~~~

  fabric context for virtualenv.

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


__all__ = ['install', 'prefix_virtualenv', 'mkvirtualenv']


@task
def install(*args, **kwargs):
  """
  installs the virtualenv
  """
  puts(blue( "\ninstalling virtualenv.." ))
  execute('sudo pip install virtualenv virtualenvwrapper ')
  puts(green( " ---> virtualenv installed.." ))
  notify.terminal('python virtual environment installed')


@task
def mkvirtualenv(*args, **kwargs):
  """
  creates the project virtualenv
  """
  puts(blue( "\ncreating project virtualenv.." ))
  execute('mkvirtualenv {workon}'.format(**env.config))
  puts(green( " ---> virtualenv created: {}..".format(**env.config)))
  notify.terminal('project virtual environment created')


# prefix / context-managers


@ctx.contextmanager
def source_virtualenv():
  """
  activates virtualenvwrapper commands
  """


@ctx.contextmanager
def prefix_virtualenv():
  """
  subsequent commands run within the virtual environment
  """
  host = environ.get_host()
  virtualenv_workon = host['workon']

  with ctx.prefix("workon {}".format(virtualenv_workon)):
    yield
