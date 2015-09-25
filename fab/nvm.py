# encoding: utf-8
"""
  fab.nvm
  ~~~~~~~

  fabric context for node version manager.

"""
from __future__ import unicode_literals
from pprint import pformat
from os import environ
from fabric.api import env
from fabric.colors import blue, green, red, yellow
from fabctx import ctx
from contextlib import nested
from fab.environ import get_host
from fab.environ import task
from fab.utils import execute
from fab.utils import puts
from fab import notify


__all__ = ['install', 'nvm_use', 'prefix_nvm']


def _nvm_path():
  with ctx.quiet():
    if env.env_id in ('local', 'test'):
      return environ.get('NVM_DIR', '')
    else:
      host = get_host()
      return "{home}/.nvm".format(**host)


@ctx.contextmanager
def nvm_use(node_version):
  """
  """
  nvm_path = _nvm_path()
  with nested(
    ctx.source('{}/nvm.sh'.format(nvm_path)),
    ctx.prefix("nvm use {}".format(node_version)) ):
    yield


@ctx.contextmanager
def prefix_nvm():
  """
  command prefix version of `nvm_use`
  """
  host = environ.get_host()
  node_version = host['node_version']
  nvm_path = _nvm_path()

  with nested(
    ctx.source('{}/nvm.sh'.format(nvm_path)),
    ctx.prefix("nvm use {}".format(node_version)) ):
    yield


@task
def install(*args, **kwargs):
  """
  installs nvm.

  see: https://github.com/creationix/nvm#install-script
  """
  puts(blue("\ninstalling node-version-manager (nvm).."))

  env.config['nvm_path'] = _nvm_path()
  env.config['nvm_install_url'] = 'https://raw.githubusercontent.com/creationix/nvm/v0.26.1/install.sh'
  execute("""
  export NVM_DIR="{nvm_path}"
  curl -o- {nvm_install_url} | bash

  echo 'export NVM_DIR="{nvm_path}"' >> {home}/.bashrc
  echo '[ -s "{nvm_path}/nvm.sh" ] && . "{nvm_path}/nvm.sh"' >> {home}/.bashrc
  echo "nvm use {node_version}" >> {home}/.bashrc

  [ -s "{nvm_path}/nvm.sh" ] && . "{nvm_path}/nvm.sh"
  nvm install {node_version}
  """.format(**env.config), capture=False)

  puts(green(" ---> node-version-manager (nvm) installed.."))
  notify.terminal('node version manager installed')
