 # encoding: utf-8
"""
  fabfile
  ~~~~~~~

  automate everything.
  see: github.com/unvael/web/wiki/04.-aws-deployment

"""
from __future__ import unicode_literals
import os
import time
from fabric.api import local
from fabric.api import env
from fabric.colors import blue, green, red, yellow
from fabctx import ctx
from fab import cron
from fab import deploy
from fab import git
from fab import laika
from fab import meteor
from fab import mongo
from fab import notify
from fab import npm
from fab import pip
from fab import supervisord
from fab import velocity
from fab import tinytest
from fab.environ import *
from fab.environ import get_host
from fab.environ import task
from fab.utils import execute
from fab.utils import approot
from fab.utils import ensure_remote_host


# commands

@task
def ssh(*args, **kwargs):
  """
  ssh onto the ec2 machine for a specified environ id.
  """
  local('ssh {hostname}'.format(**get_host()))


@task
def tail(*args, **kwargs):
  """
  tail meteor app log output.
  """
  execute('tail -f {root}/logs/meteor-{env_id}.log'.format(**get_host()))


@task
def mongo(*args, **kwargs):
  """
  runs the mongodb console locally with the development db.
  """
  local('mongo -u {db_user} -p {db_pswd} {db_host}/{db_name}'.format(
    **env.config))


@task
def start(*args, **kwargs):
  """
  starts supervisord, meteor, crontab
  """
  host = get_host()
  with approot(host):
    stop()

  # TODO: we should change this to a polling loop..
  WAIT_TIMER = 5
  time.sleep(WAIT_TIMER)  # wait for shutdown..

  meteor.render_packages_file()
  with approot(host):
    supervisord.start()
    supervisord.start_meteor()
    cron.create()


@task
def stop(*args, **kwargs):
  """
  stops supervisord, crontabs
  """
  supervisord.stop()
  cron.remove()
