# encoding: utf-8
"""
  fab.deploy
  ~~~~~~~~~~

  helpers for deploying to amazon-aws using github.

"""
from __future__ import unicode_literals
from pprint import pformat
from fabric.api import run
from fabric.api import execute as _exec
from fabric.colors import blue, green, red, yellow
from fabctx import ctx
from contextlib import nested
from fab import git
from fab import notify
from fab import pip
from fab.environ import task
from fab.environ import prefix_cd_approot
from fab.utils import execute
from fab.utils import ensure_remote_host
from fab.utils import puts


__all__ = ['setup_host', 'hotcodereload', 'full']


@task
def setup_host(*args, **kwargs):
  """
  installs the environment + meteor app on a new host.

  installs nvm, meteor, lib dependencies.
  """
  puts(blue( "\nsetting up aws-instance host.." ))
  # git setup ssh-deploy-key

  _exec('bashrc.install')
  _exec('git.install')
  _exec('git.clone')
  _exec('virtualenv.install')
  _exec('virtualenv.mkvirtualenv')
  _exec('pip.install_requirements')
  _exec('nvm.install')
  _exec('npm.install')

  puts(green( " ---> aws-instance host setup completed.." ))
  notify.terminal('aws instance host setup completed')


@task
def hotcodereload(*args, **kwargs):
  """
  updates app from github to quick deploy via meteor 'hot-code-reload'
  """
  ensure_remote_host()
  puts(blue('\nhotcodereloading meteor-app..'))

  with prefix_cd_approot():
    git.update()
    # TODO: parse change-file-list for supervisord.conf to re-render..
    # if 'supervisor.template.conf' in git.changed_files():
    #   supervisord.conf()

  puts(green(" ---> meteor-app hotcodereloaded.."))
  notify.meteor_app_deployed()


@task
def full(*args, **kwargs):
  """
  full-deploy of the app to amazon-aws, including pip + meteor updates.
  """
  ensure_remote_host()
  puts(blue('\nfull-deploying meteor-app..'))

  with ctx.warn_only():
    execute('touch /tmp/flvnt-web-supervisor.sock')

  pip.update()
  # TODO: use remote $HOME env variable instead of path set in config..
  with prefix_cd_approot():
    git.update()
    _exec('start')

  puts(green(" ---> meteor-app deployed.."))
  notify.meteor_app_deployed()
