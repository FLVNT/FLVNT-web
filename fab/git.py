# encoding: utf-8
"""
  fab.git
  ~~~~~~~

  fabric context for git + github.

"""
from __future__ import unicode_literals
from pprint import pformat
from fabric.api import env
from fabric.api import run
from fabric.colors import blue, green, red, yellow
from fabctx import ctx
from fab.environ import get_host
from fab.environ import task
from fab.environ import prefix_cd_approot
from fab.utils import execute
from fab.utils import puts
from fab import notify


__all__ = ['install', 'clone', 'update']


@task
def install(*args, **kwargs):
  """
  installs git
  """
  puts(blue( "\ninstalling git.." ))
  execute('sudo apt-get update && sudo apt-get install git ')
  puts(green( " ---> git installed.." ))
  notify.terminal('git installed')


@task
def clone(*args, **kwargs):
  """
  git-clones the project repo.
  """
  puts(blue( "\ngit-cloning project repo.." ))

  with prefix_cd_approot():
    execute('git clone git@github.com:{git_repo}.git'.format(**env.config))
    puts(green( " ---> project repo cloned.." ))
    notify.terminal('project repo cloned')


@task
def update(*args, **kwargs):
  """
  updates the application from git
  """
  puts(blue( "\nupdating app from git.." ))

  _fn = run
  if env.env_id in ('local', 'test'):
    _fn = execute

  host = get_host()
  branch = host['branch']

  with ctx.warn_only():
    _fn("git stash")

  with ctx.warn_only():
    _fn( "git checkout {}".format( branch ))

  with ctx.warn_only():
    _fn( "git pull origin {}".format( branch ))

  puts(green( " ---> host updated from git.." ))
