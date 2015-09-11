# encoding: utf-8
"""
  fab.environ
  ~~~~~~~~~~~

  module for environment fabric helpers.

"""
from __future__ import unicode_literals
from pprint import pformat
from os import getenv, environ
import simplejson as json
from fabric.api import env
from fabric.colors import blue, green, red, yellow
from fabric.api import task as _task


__all__ = ['test', 'stage', 'prod', 'get_host', 'task', 'env', 'set_env']


# environment specific host settings. SHOULD be named `HOSTS` - but that
# collides with fabric internals.
# TODO: refactor to inhertiable classes
env.ENVS = {
  'test': {
    'hostname'     : None,
    'hostname_ip'  : '127.0.0.1',
    'branch'       : None,
    'root'         : None,
    'workon'       : None,
    'node_version' : '0.10.26',
    'home'         : '.',
    'npm_libs'     : 'coffee-script jade stylus node-inspector laika meteorite',
    'loglevel'     : 'trace',
    'app_root'     : 'app',
    'stdout'       : 'logs/test.log',
    'env_vars'     : dict(
      ENV_ID='test',
      ROOT_URL='',
      MONGO_URL='',
    ),
  },
  'local': {
    'hostname'     : None,
    'hostname_ip'  : '127.0.0.1',
    'branch'       : None,
    'root'         : None,
    'workon'       : None,
    'node_version' : '0.10.26',
    'home'         : '.',
    'npm_libs'     : 'coffee-script jade stylus node-inspector laika',
    'loglevel'     : 'debug',
    'app_root'     : 'app',
    'stdout'       : 'logs/app.log',
    'env_vars'     : dict(
      ENV_ID='local',
      ROOT_URL='',
      MONGO_URL='',
    ),
  },
  'stage': {
    'hostname'     : 'flvnt-web-stage-01',
    'hostname_ip'  : '54.xx.xxx.xx',
    'branch'       : 'develop',
    'root'         : '/home/ubuntu/web',
    'workon'       : 'flvnt-dev',
    'node_version' : '0.10.26',
    'home'         : '/home/ubuntu',
    'npm_libs'     : 'coffee-script jade stylus node-inspector laika',
    'loglevel'     : 'debug',
    'app_root'     : 'app',
    'stdout'       : 'logs/app.log',
    'env_vars'     : dict(
      ENV_ID='stage',
      ROOT_URL='',
      MONGO_URL='',
    ),
  },
  'prod': {
    'hostname'     : 'flvnt-web-prod-01',
    'hostname_ip'  : '52.26.88.253',
    'hostname_id'  : 'i-2532aee3',
    'branch'       : 'develop',
    'root'         : '/home/ubuntu/web',
    'workon'       : 'flvnt-dev',
    'node_version' : '0.10.26',
    'home'         : '/home/ubuntu',
    'npm_libs'     : 'coffee-script jade stylus node-inspector laika',
    'loglevel'     : 'debug',
    'app_root'     : 'app',
    'stdout'       : 'logs/app.log',
    'env_vars'     : dict(
      ENV_ID='prod',
      ROOT_URL='',
      MONGO_URL='',
    ),
  },
}


env.env_id = getenv('ENV_ID', 'local')
env.config = dict(env_id=env.env_id)
env.use_ssh_config = True


def set_env():
  environ['ENV_ID'] = env.env_id
  _ctx = get_host()
  env.config.update(_ctx)
  env_json_path = '{app_root}/private/env-{env_id}.json'.format(**env.config)

  with open(env_json_path, 'r') as f:
    _json = f.read()
    if _json is None or len(_json) < 1:
      print(red('set_env failed, {} is empty..'.format(env_json_path)))
      return
    _json = json.loads(_json)
    env.config.update(_json)

  if env.hosts is None and _ctx['hostname'] is not None:
    env.hosts = [_ctx['hostname']]

  # build the mongo url
  # TOOD: needs to be a list for replica-sets, and read-vs-write slaves
  env.config['mongo_url'] = "mongodb://{user}:{pswd}@{uri}".format(
    uri =env.config['db_uri'],
    user=env.config['db_user'],
    pswd=env.config['db_pswd'],
    host=env.config['db_host'],
    name=env.config['db_name'])

  env.config['meteor_release_version'] = meteor_release_version()


def task(*a, **kw):
  """
  method decorator run a fabric task ensuring set_env wraps the inner call
  """
  set_env()
  return _task(*a, **kw)


def get_host():
  """
  returns configuration mapping for the current environment host
  """
  result = env.ENVS[env.env_id]
  result['env_id'] = env.env_id
  return result


def meteor_release_version():
  """
  reads the meteor release version from `app/.meteor/release`
  """
  version = ''
  # print '1'
  with open('app/.meteor/release', 'r') as f:
    # print '2'
    version = f.read().strip()
    # print '3'
  return version


# helpers to set the fabric.env.env_id

@task(display=None)
def test():
  """
  sets the env_id to `test`
  """
  env.env_id = 'test'
  set_env()
  print(blue('[TEST]'))


@task(display=None)
def stage():
  """
  sets the env_id to `stage`
  """
  env.env_id = 'stage'
  set_env()
  print(blue('[STAGE]'))


@task(display=None)
def prod():
  """
  sets the env_id to `prod`
  """
  env.env_id = 'prod'
  set_env()
  print(blue('[PROD]'))
