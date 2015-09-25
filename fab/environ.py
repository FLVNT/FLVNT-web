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
from fabric.api import cd, lcd
from fabric.colors import blue, green, red, yellow
from fabric.api import task as _task
from fabctx import ctx
from fabctx import virtualenv
from contextlib import nested
from fab.utils import puts


__all__ = ['test', 'stage', 'prod', 'get_host', 'task', 'env', 'set_env',
'prefix_host_shell', 'prefix_cd_approot']


# environment specific host settings. SHOULD be named `HOSTS` - but that
# collides with fabric internals.
# TODO: refactor to inhertiable classes
env.ENVS = {
  'test': {
    'app_id'       : 'flvnt-web',
    'git_repo'     : 'FLVNT/FLVNT-web',
    'email_host'   : 'flvnt.com',
    'hostname'     : None,
    'hostname_ip'  : '127.0.0.1',
    'branch'       : None,
    'root'         : None,
    'home'         : '.',
    'workon'       : None,
    'node_version' : '0.10.26',
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
    'app_id'       : 'flvnt-web',
    'git_repo'     : 'FLVNT/FLVNT-web',
    'email_host'   : 'flvnt.com',
    'hostname'     : None,
    'hostname_ip'  : '127.0.0.1',
    'branch'       : None,
    'root'         : None,
    'home'         : '.',
    'workon'       : None,
    'node_version' : '0.10.26',
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
    'app_id'       : 'flvnt-web',
    'git_repo'     : 'FLVNT/FLVNT-web',
    'email_host'   : 'flvnt.com',
    'hostname'     : 'flvnt-web-stage-01',
    'hostname_ip'  : '54.xx.xxx.xx',
    'branch'       : 'develop',
    'root'         : '/home/ubuntu/FLVNT-web',
    'home'         : '/home/ubuntu',
    'workon'       : 'flvnt-dev',
    'node_version' : '0.10.26',
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
    'app_id'       : 'flvnt-web',
    'git_repo'     : 'FLVNT/FLVNT-web',
    'email_host'   : 'flvnt.com',
    'hostname'     : 'flvnt-web-prod-01',
    'hostname_ip'  : '52.26.88.253',
    'hostname_id'  : 'i-2532aee3',
    'branch'       : 'develop',
    'root'         : '/home/ubuntu/FLVNT-web',
    'home'         : '/home/ubuntu',
    'workon'       : 'flvnt-dev',
    'node_version' : '0.10.26',
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
env.use_ssh_config      = True
env.forward_agent       = True
env.colorize_errors     = True
env.dedupe_hosts        = True
env.disable_known_hosts = False
env.eagerly_disconnect  = False
env.no_agent            = False
env.no_keys             = False
env.skip_bad_hosts      = False
env.output_prefix       = False
# env.combine_stderr = True
# env.parallel = True
# env.linewise = True
# env.output_prefix = False
# env.ssh_config_path = '$HOME/.ssh/config'

# http://docs.fabfile.org/en/1.6/usage/env.html#command-prefixes
# env.command_prefixes = []


@ctx.contextmanager
def prefix_environ_vars():
  """
  context-manager to prefix commands with the `ENV_ID` environment variable set
  to `env.env_id`
  """
  _env_vars = dict(ENV_ID=env.env_id)
  with ctx.shell_env(**_env_vars):
    yield


@ctx.contextmanager
def prefix_host_shell():
  """
  contextmanager to run a task on a remote host, setting the shell prefixes
  with the python virtualenv, and the nvm node-version.
  """
  host = get_host()
  _virtualenv_id = host['workon']
  _node_version  = host['node_version']

  from fab import nvm

  with nested(
    prefix_environ_vars(),
    virtualenv.workon(_virtualenv_id),
    nvm.nvm_use(_node_version),
    prefix_cd_approot()):

    yield


@ctx.contextmanager
def prefix_cd_approot():
  """
  method decorator to run a command from the application root dir.
  """
  _cd = cd
  if env.env_id in ('local', 'test'):
    _cd = lcd

  host = get_host()
  root_path = host.get('root')
  with _cd(root_path):
    yield


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

  if (env.hosts is None or len(env.hosts) < 1) and _ctx.get('hostname', None):
    env.hosts = [_ctx.get('hostname')]

  # build the mongo url
  # TOOD: needs to be a list for replica-sets, and read-vs-write slaves
  env.config['mongo_url'] = "mongodb://{user}:{pswd}@{uri}".format(
    uri =env.config['db_uri'],
    user=env.config['db_user'],
    pswd=env.config['db_pswd'],
    host=env.config['db_host'],
    name=env.config['db_name'])

  # TODO: move this back to meteor.py
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
  with open('app/.meteor/release', 'r') as f:
    version = f.read().strip()
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
