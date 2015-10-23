# encoding: utf-8
"""
  fab.supervisord
  ~~~~~~~~~~~~~~~

  fabric for supervisord.

"""
from __future__ import unicode_literals
from pprint import pformat
import os
from fabric.api import env
from fabric.colors import blue, green, red, yellow
from fabctx import ctx
from contextlib import nested
from fab.environ import get_host
from fab.environ import task
from fab.utils import execute
from fab.environ import *
from fab import jinja
from fab.utils import puts


__all__ = [
  # supervisorctl
  'setup', 'conf', 'start', 'stop', 'reload_config', 'tail',
  # meteor
  'start_meteor', 'stop_meteor', 'restart_meteor',
  # mongod
  'start_mongod', 'stop_mongod',
]


def _init_socket():
  """
  initalizes the supervisor socket
  """
  with ctx.warn_only():
    sock_path = '/tmp/{}'.format(get_host()['supervisord_sock'])
    execute('touch {}'.format(sock_path))

    print(green(' ---> supervisord: socket initialized..'))


def _load_conf(conf_path="supervisord.template.conf"):
  """
  loads conf template and returns an instance of a `jinja2.Environment`
  """
  with open(conf_path, 'r') as f:
    text = f.read()

  return jinja.env_dict(conf_path, text)


def _write_conf(env_dict, context, out_path):
  """
  writes the `supervisord.conf` file to disk from the template.
  """
  for name, _ in env_dict.loader.mapping.iteritems():
    jinja.render(
      env_dict.get_template(name), context, out_path)



# TODO: rename to render_conf .. ?
@task
def conf(*args, **kwargs):
  """
  writes the `supervisord.conf` file to disk from the template.
  """
  print(blue("\nrendering ./supervisord.conf.."))

  _ctx = env.config.copy()
  _ctx.update(get_host())
  _write_conf(_load_conf(), _ctx, out_path='supervisord.conf')

  print(green(' ---> ./supervisord.conf rendered: supervisord.conf..'))


@task
def setup(*args, **kwargs):
  """
  configures supervisord socket + conf template.
  """
  _init_socket()
  conf()


@task
def tail(*args, **kwargs):
  """
  tail supervisord log output
  """
  execute("tail -f supervisord.log")


@task
def cat(lines=None, *args, **kwargs):
  """
  cat supervisord log output
  """
  log = execute("cat supervisord.log".format(str(lines)))
  print 'log', log


@task
def start(*args, **kwargs):
  """
  starts supervisord
  """
  print(blue("\nstarting supervisor.."))
  with ctx.warn_only():
    try:
      out = execute("supervisord -c supervisord.conf", capture=False)
    except Exception as e:
      print(red(e))


@task
def stop(*args, **kwargs):
  """
  stops supervisord
  """
  print(blue("\nstopping supervisord.."))
  with ctx.warn_only():
    execute("supervisorctl -c supervisord.conf shutdown", capture=False)


@task
def reload_config(*args, **kwargs):
  """
  updates supervisord config
  """
  print(blue("\nreloading supervisord.conf.."))
  with ctx.warn_only():
    execute("supervisorctl -c supervisord.conf update", capture=False)


# METEOR

@task
def start_meteor(*args, **kwargs):
  """
  starts the supervisor meteor-app
  """
  print(blue("\nstarting meteor-app.."))
  execute("supervisorctl start meteor-{id}".format(**env.config), capture=False)


@task
def stop_meteor(*args, **kwargs):
  """
  stops the supervisor meteor-app
  """
  print(blue("\nstopping meteor-app.."))
  with ctx.warn_only():
    execute("supervisorctl stop meteor-{id}".format(**env.config), capture=False)

@task
def restart_meteor(*args, **kwargs):
  """
  restarts the supervisor meteor-app
  """
  print(blue("\nrestarting meteor-app.."))
  with ctx.warn_only():
    execute("supervisorctl restart meteor-{id}".format(**env.config), capture=False)


# MONGO

@task
def start_mongod(*args, **kwargs):
  """
  starts the supervisor mongod
  """
  print(blue("\nstarting mongod.."))

  out = execute("supervisorctl start mongod-{id}".format(**env.config))

  if out and 'ERROR' in out:
    cat(lines=25)
    print(red(out))
    return

  print(out)


@task
def stop_mongod(*args, **kwargs):
  """
  stops the supervisor mongod
  """
  print(blue("\nstopping mongod.."))
  with ctx.warn_only():
    execute("supervisorctl stop mongod-{id}".format(**env.config))
