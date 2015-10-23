# encoding: utf-8
"""
  fab.mongo
  ~~~~~~~~~

  fabric for mongodb.

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


__all__ = ['start', 'shell']


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


def _construct_mongo_url():
  """
  formats a mongodb connection url.
  """
  # TODO


@task
def shell(*args, **kwargs):
  """
  runs the mongodb console locally with the development db.
  """
  local('mongo -u {db_user} -p {db_pswd} {db_host}/{db_name}'.format(
    **env.config))
