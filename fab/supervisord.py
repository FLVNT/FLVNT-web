# encoding: utf-8
"""
  fab.supervisord
  ~~~~~~~~~~~~~~~

  context for supervisord.

"""
from __future__ import unicode_literals
import os
from fabric.api import env
from fab.environ import task
from fabric.colors import blue
from fabctx import ctx
from fab.utils import execute
from fab.environ import *
from jinja2 import Environment
from jinja2.loaders import DictLoader


__all__ = [
  'setup', 'conf', 'start', 'stop', 'update_config',
  'start_meteor', 'stop_meteor', 'restart_meteor',
  'start_mongod', 'stop_mongod',
]


def init_socket():
  """
  initalizes the supervisor socket
  """
  with ctx.warn_only():
    sock_path = '/tmp/{}'.format(get_host()['supervisord_sock'])
    execute('touch {}'.format(sock_path))


def _render_conf(name, template, context, out_path):
  """
  renders the supervisord configuration and writes it to a file.

    :param template: instance of a jinja2 template object
    :param context: instance of a dict
    :param out_path: string file path
  """
  with open(out_path, 'w') as f:
    f.write(template.render(**context))


def _load_conf(conf_path="supervisord.template.conf"):
  """
  loads conf template and returns an instance of a `jinja2.Environment`
  """
  with open(conf_path, 'r') as f:
    text = f.read()
    loader = DictLoader({str(conf_path): str(text)})
    env = Environment(loader=loader)

  return env


def _write_conf(jinjaenv, context, out_path):
  """
  writes the `supervisord.conf` file to disk from the template.
  """
  for name, _ in jinjaenv.loader.mapping.iteritems():
    _render_conf(
      name.replace(".template", ""),
      jinjaenv.get_template(name), context, out_path)


@task
def conf(*args, **kwargs):
  """
  writes the `supervisord.conf` file to disk from the template.
  """
  ctx = env.config.copy()
  ctx.update(get_host())
  _write_conf(_load_conf(), ctx, out_path='supervisord.conf')


@task
def setup(*args, **kwargs):
  """
  configures supervisord socket + conf template.
  """
  init_socket()
  conf()


@task
def start(*args, **kwargs):
  """
  starts supervisord
  """
  print(blue("starting supervisor.."))
  execute("supervisord -c supervisord.conf")


@task
def stop(*args, **kwargs):
  """
  stops supervisord
  """
  print(blue("stopping supervisord.."))
  with ctx.warn_only():
    execute("supervisorctl -c supervisord.conf shutdown")


@task
def update_config(*args, **kwargs):
  """
  updates supervisord config
  """
  print(blue("re-reading supervisord conf.."))
  with ctx.warn_only():
    execute("supervisorctl -c supervisord.conf update")


# METEOR

@task
def start_meteor(*args, **kwargs):
  """
  starts the supervisor meteor-app
  """
  print(blue("starting meteor.."))
  execute("supervisorctl start meteor-{id}".format(**env.config))


@task
def stop_meteor(*args, **kwargs):
  """
  stops the supervisor meteor-app
  """
  print(blue("stopping meteor.."))
  with ctx.warn_only():
    execute("supervisorctl stop meteor-{id}".format(**env.config))

@task
def restart_meteor(*args, **kwargs):
  """
  restarts the supervisor meteor-app
  """
  print(blue("restarting meteor.."))
  with ctx.warn_only():
    execute("supervisorctl restart meteor-{id}".format(**env.config))


# MONGO

@task
def start_mongod(*args, **kwargs):
  """
  starts the supervisor mongod
  """
  print(blue("starting mongod.."))
  execute("supervisorctl start mongod-{id}".format(**env.config))

@task
def stop_mongod(*args, **kwargs):
  """
  stops the supervisor mongod
  """
  print(blue("stopping mongod.."))
  with ctx.warn_only():
    execute("supervisorctl stop mongod-{id}".format(**env.config))
