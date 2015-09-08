# encoding: utf-8
"""
  fab.deploy
  ~~~~~~~~~~

  helpers for deploying to amazon-aws using github.

"""
from __future__ import unicode_literals
from fabric.api import run
from fab.environ import task
from fabric.colors import blue
from fabctx import ctx
from fab import git
from fab import notify
from fab import pip
from fab.environ import get_host
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
  host = get_host()
  with approot(host):
    git.update(host)
    # TODO: parse change-file-list for supervisord.conf to re-render?
    # supervisord.supervisord_conf()
  notify.meteor_app_deployed()


@task
def full(*args, **kwargs):
  """
  full-deploy of the app to amazon-aws, including pip + mrt updates.
  """
  ensure_remote_host()
  pip.update()
  # update_mrt()
  host = get_host()
  # TODO: use remote $HOME env variable instead of path set in config..
  with approot(host):
    git.update(host)
    start()
  notify.meteor_app_deployed()
