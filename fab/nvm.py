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
from fab.environ import get_host
from fab.environ import task
from fab.utils import execute


__all__ = ['nvm_use', 'nvm_install']


def _nvm_path():
  with ctx.quiet():
    if env.env_id in ('local', 'test'):
      return environ.get('NVM_DIR', '')
    else:
      return "{}/.nvm".format(ctx.home())


@ctx.contextmanager
def nvm_use(version):
  with ctx.source('{}/nvm.sh'.format(_nvm_path())):
    with ctx.prefix("nvm use {}".format(version)):
      yield


@task
def nvm_install(*args, **kwargs):
  """
  installs nvm.
  """
  print(blue("installing node-version-manager (nvm).."))

  env.config['nvm_install_url'] = 'https://raw.githubusercontent.com/creationix/nvm/v0.7.0/install.sh'
  execute("""
  curl {nvm_install_url} | sh
  echo '[ -s "{home}/.nvm/nvm.sh" ] && . "{home}/.nvm/nvm.sh"' >> {home}/.bashrc
  echo "nvm use {node_version}" >> {home}/.bashrc
  [ -s "{home}/.nvm/nvm.sh" ] && . "{home}/.nvm/nvm.sh"
  nvm install {node_version}
  """.format(**env.config))

  print(green(" ---> node-version-manager (nvm) installed.."))
