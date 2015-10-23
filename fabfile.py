# encoding: utf-8
"""
  fabfile
  ~~~~~~~

  automate everything.

  see: github.com/FLVNT/FLVNT-web/wiki/04.-aws-deployment

"""
from __future__ import unicode_literals
from pprint import pformat
import os
import time
from fabric.api import local
from fabric.api import env
from fabric.colors import blue, green, red, yellow
from fabctx import ctx
from contextlib import nested
from fab import cron
from fab import deploy
from fab import git
from fab import hub
from fab import laika
from fab import meteor
from fab import mongo
from fab import notify
from fab import bashrc
from fab import npm
from fab import nvm
from fab import pip
from fab import ssh
from fab import supervisord
from fab import velocity
from fab import tinytest
# from fab import handler
from fab.environ import env, get_host
from fab.environ import test, stage, prod
from fab.environ import task
from fab.environ import prefix_cd_approot
from fab.utils import execute
from fab.utils import ensure_remote_host
from fab.utils import puts
import atexit
import signal


@task
def tail(*args, **kwargs):
  """
  tail meteor-app log output
  """
  with prefix_cd_approot():
    execute('tail -f ./logs/app.log')


@task
def start(*args, **kwargs):
  """
  starts supervisord, meteor, crontabs
  """
  with prefix_cd_approot():
    stop()

  # TODO: we should change this to a polling loop..
  WAIT_TIMER = 5
  time.sleep(WAIT_TIMER)  # wait for shutdown..

  meteor.render_packages_file()
  with prefix_cd_approot():
    supervisord.start()
    supervisord.start_meteor()
    cron.create()


@task
def stop(*args, **kwargs):
  """
  stops supervisord, meteor, crontabs
  """
  supervisord.stop()
  cron.remove()



def signal_handler(*args, **kwargs):
  if len(args) > 1:
    print red( '\t * {}'.format(args) )

  if len(kwargs) > 1:
    print red( '\t * {}'.format(kwargs) )

  # print pformat(env)
  # for r in env.resources_log:
  #   print red( '\t * '.format(r) )


# atexit.register(signal_handler)
# note: this doesn't work at catching ctrl-c w/ multiprocessing code..
# signal.signal(signal.SIGINT,  signal_handler)
# signal.signal(signal.SIGTERM, signal_handler)
