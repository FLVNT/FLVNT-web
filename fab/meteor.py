# encoding: utf-8
"""
  fab.meteor
  ~~~~~~~~~~

  context for meteor.

"""
from __future__ import unicode_literals
from pprint import pformat
from fabric.api import env
from fabric.api import cd, lcd
from fabric.api import env
from fab.environ import task, set_env
from fabric.colors import blue, green, red, yellow
from fabctx import ctx
from simplejson import loads
from fab import environ
from fab import supervisord
from fab import nvm
from fab.environ import meteor_release_version
from fab.environ import get_host
from fab.utils import execute
from DDPClient import DDPClient


__all__ = ['install', 'update', 'meteor_release_version', 'meteor_shell',
'meteor_env', 'set_accounts_config', 'clean_build_cache', 'render_packages_file',
'run', 'run_local', 'create_package']


def _load_json(filepath):
  with open(filepath) as f:
    result = loads(f.read().strip())
    del f
  return result


def meteor_env():
  set_env()
  return {
    "ENV_ID"    : env.env_id,
    "ROOT_URL"  : env.config['root_url'],
    "MONGO_URL" : env.config['mongo_url'],
    # "KADIRA_PROFILE_LOCALLY": '1',
  }


@ctx.contextmanager
def meteor_approot():
  """
  sets the context to the meteor app dir.
  """
  fn = cd
  if env.env_id in ('local', 'test'):
    fn = lcd

  with fn("./app/"):
    yield


@ctx.contextmanager
def meteor_shell(**kwargs):
  """
  sets the shell context for the meteor command.
  """
  _env = meteor_env()
  _env.update(kwargs)
  with meteor_approot():
    with ctx.shell_env(**_env):
      try:
        yield
      except Exception, e:
        print(red(' ---> {}'.format(e)))


@task
def clean_build_cache(*args, **kwargs):
  """
  removes the '.meteor/local' dir
  """
  print(blue("cleaning meteor build-cache.."))
  with ctx.warn_only():
    execute('rm -rf {}'.format('./app/.meteor/local/*'))
    print(green(" ---> meteor: build-cache cleaned: './app/.meteor/local/'"))


@task
def update(*args, **kwargs):
  """
  update to the latest meteor release for the app.

    EXPECT ERRORS, USE CAUTION, ABANDON HOPE.

  """
  with meteor_shell():
    # TODO: add handler for SIGINT to detect update success/error
    execute("meteor update")


@task
def set_accounts_config(*args, **kwargs):
  """
  updates the specified environs database accounts service configuration.
  """

  def _callback(err, data):
    client.close()
    if err:
      print err
    else:
      print data

  set_env()
  _ctx = env.config.copy()
  _ctx.update(get_host())

  socket_url = 'ws://{app_host}:{app_port}/websocket'.format(**_ctx)
  client = DDPClient(socket_url, auto_reconnect=True, auto_reconnect_timeout=1)

  import socket
  try:
    client.connect()
  except socket.error, e:
    print red('\n---> unable to connect to socket_url: {}  [check meteor-app is running..]'.format(socket_url))
  else:
    call_args = []
    client.call('reset_accounts_config', call_args, _callback)


@task
def install(*args, **kwargs):
  """
  installs nvm, meteor, npm global dependencies
  """
  nvm.install()

  _ctx = env.config.copy()
  _ctx.update(get_host())
  _ctx['meteor_install_url'] = 'https://install.meteor.com/'

  # install npm-libs
  execute("""
  nvm use {node_version}
  npm install -g {npm_libs}
  """.format(**_ctx))

  # install meteor..
  execute("curl {meteor_install_url} | sh".format(**_ctx))

  # install laika test-runner..
  laika.install()
  with meteor_shell():
    execute("""
    nvm use {node_version}
    npm install -g laika
    """.format(**_ctx))


@task
def meteor_debug(*args, **kwargs):
  """
  updates the specified environs database accounts service configuration.
  """
  with meteor_shell():
    shstr = '''
    npm install -g node-inspector
    node-inspector &
    export NODE_OPTIONS='--debug-brk'
    meteor
    '''
    execute(shstr)


@task
def run_local(*args, **kwargs):
  """
  runs the meteor app locally with a local db.
  """
  supervisord.stop()
  supervisord.conf()
  supervisord.start()
  supervisord.start_mongod()

  set_env()
  _ctx = env.config.copy()
  _ctx.update(get_host())

  # _ctx.pop("db_uri")
  # _ctx.pop("db_host")
  # _ctx.pop("db_user")
  # _ctx.pop("db_pswd")
  # _ctx.pop("db_name")

  # TODO: format mongo-url
  _ctx['mongo_env_url'] = ''

  render_packages_file()
  with meteor_shell():
    execute(
      "MONGO_URL='{mongo_env_url}' && meteor "
      "--port {app_port} "
      "--release {meteor_release_version} "
      "--settings private/env-{id}.json".format(**_ctx))


@task
def run(*args, **kwargs):
  """
  runs the meteor app locally with the development db.
  """
  supervisord.conf()
  render_packages_file()
  with meteor_shell():
    print(blue("starting meteor-app.."))
    execute(
      "meteor "
      "--port {app_port} "
      "--release {meteor_release_version} "
      "--settings private/env-{id}.json".format(**env.config))



# PACKAGE MANAGEMENT HELPERS
# -----------------------------------------------------------------------------

@task
def create_package(name, *args, **kwargs):
  """
  create a boilerplate meteor package

  usage:
      $ fab meteor.create_package:fixtures

  """
  with ctx.warn_only():
    execute('''
      cd ./app
      meteor create --package {name}
      ls ./packages/{name}/
    '''.format(name=name))


@task
def render_packages_file(*args, **kwargs):
  """
  compiles + renders  '.meteor/packages.json'  to  '.meteor/packages'

  packages delcared in a nested structure allows for a natural self-documenting.
  """
  print(blue("rendering ./.meteor/packages.."))

  host = get_host()
  packages_file = '{app_root}/.meteor/packages'.format(**host)
  # load the 'packages.json' file
  # TODO: refactor open() to use fab.execute()
  packages_json = _load_json('{}.json'.format(packages_file))
  categories = packages_json.keys()
  ln = []

  for category,packages in packages_json.items():
      if category in ('debugging',):
        continue

      banner = '# ' + ''.join(['-' for i in range(len(category) + 2)])
      ln.append('\n# {}\n{}'.format(category,banner))

      if isinstance(packages, list):
        for package,version in packages.items():
          ln.append("{}".format(package))

      elif isinstance(packages, dict):
        for package,version in packages.iteritems():
          if version is None or version is '':
            ln.append("{}".format(package))

          elif isinstance(version, str):
            if version.upper() != "TODO":
              ln.append("{}@{}".format(package, version))
            else:
              ln.append("{}".format(package))

          # recursive object
          elif isinstance(version, dict):
            pass  # not implemented

      # one more white-space line for readability's sake
      ln.append('')

  # write the 'packages' file
  with open(packages_file, 'w') as f:
    f.write('\n'.join(ln))

  print(green(" ---> meteor: {} file rendered..\n".format(packages_file)))
