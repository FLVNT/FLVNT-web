# encoding: utf-8
"""
  fab.mongo
  ~~~~~~~~~

  context for mongo-db.

"""
from __future__ import unicode_literals
from fabric.api import env
from fabric.api import cd, lcd
from fabctx import ctx
from fab.environ import task
from fab.utils import execute


__all__ = ['start', 'construct_mongo_url']


@task
def start(env_id):
  """
  runs a local instance of mongod via supervisor-ctl.
  """
  # command = "mongod-{}".format(env_id)
  with ctx.shell_env(**env.config):
  # with ctx.warn_only():
    # rv = execute("supervisorctl start {}".format(command), capture=True)
    # if '{}: started'.format(command) not in rv:
    #   raise Exception('could not start mongod: {}'.format(rv))
    pass


def construct_mongo_url():
  """
  formats a mongodb connection url.
  """
  # TODO
