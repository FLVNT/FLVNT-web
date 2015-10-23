# encoding: utf-8
"""
  fab.npm
  ~~~~~~~

  fabric for node package manager.

"""
from __future__ import unicode_literals
from pprint import pformat
from fabric.api import env
from fabric.colors import blue, green, red, yellow
from fabctx import ctx
from fab.environ import get_host
from fab.environ import task
from fab.utils import execute
from fab.utils import puts
from fab import notify
from fab import meteor


__all__ = ['install', 'install_node_inspector']


@task
def install(*args, **kwargs):
  """
  installs npm packages globally
  """
  puts(blue("\ninstalling node-packages.."))

  _ctx = env.config.copy()
  _ctx.update(get_host())

  with meteor.meteor_shell():
    execute("npm install -g {npm_libs}".format(**_ctx), capture=False)

  puts(green(" ---> node-packages installed.."))
  notify.terminal('node packages installed')


@task
def install_node_inspector(*args, **kwargs):
  """
  installs node-inspector npm package globally
  """
  with meteor.meteor_shell():
    execute("npm install -g node-inspector", capture=False)
