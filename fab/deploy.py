# encoding: utf-8
"""
  fab.deploy
  ~~~~~~~~~~

  helpers for deploying to amazon-aws using github.

"""
from __future__ import unicode_literals
from pprint import pformat
from fabric.api import run
from fabric.colors import blue, green, red, yellow
from fabctx import ctx
from fab import git
from fab import notify
from fab import pip
from fab.environ import get_host
from fab.environ import task
from fab.utils import execute
from fab.utils import approot
from fab.utils import ensure_remote_host


__all__ = ['setup_host', 'hotcodereload', 'full']


@task
def setup_host(*args, **kwargs):
  """
  installs the environment + meteor app on a new host.

  installs nvm, meteor, lib dependencies.
  """


@task
def hotcodereload(*args, **kwargs):
  """
  updates app from github to quick deploy via meteor 'hot-code-reload'
  """
  ensure_remote_host()
  print blue('hotcodereloading meteor-app..'.format(_host_text))

  host = get_host()
  with approot(host):
    git.update(host)
    # TODO: parse change-file-list for supervisord.conf to re-render..
    # if 'supervisor.template.conf' in git.changed_files():
    #   supervisord.conf()

  print(green(" ---> meteor-app hotcodereloaded.."))
  notify.meteor_app_deployed()


@task
def full(*args, **kwargs):
  """
  full-deploy of the app to amazon-aws, including pip + mrt updates.
  """
  ensure_remote_host()
  print blue('full-deploying meteor-app..'.format(_host_text))

  pip.update()
  # update_mrt()
  host = get_host()
  # TODO: use remote $HOME env variable instead of path set in config..
  with approot(host):
    git.update(host)
    start()

  print(green(" ---> meteor-app deployed.."))
  notify.meteor_app_deployed()
