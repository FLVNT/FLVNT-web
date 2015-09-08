# encoding: utf-8
"""
  fab.cron
  ~~~~~~~~

  fabric commands + context for working with crontabs.

"""
from __future__ import unicode_literals
from fabric.api import env
from fab.environ import task
from fabric.colors import blue
from fabctx import ctx
from fab import environ
from fab.utils import execute
from jinja2 import Environment
from jinja2.loaders import DictLoader


__all__ = ['create', 'remove', 'tail']


CRON_FILE = 'cron'


@task
def create(*args, **kwargs):
  """
  invoke crontab to set cron jobs
  """
  remove()
  _create_cron_txt()
  execute('crontab {}.txt && crontab -l'.format(CRON_FILE))


@task
def remove(*args, **kwargs):
  """
  remove existing crons
  """
  with ctx.quiet():
    execute('crontab -r')


@task
def tail(*args, **kwargs):
  """
  tail cron log output.
  """
  execute('tail -f {}/logs/cron.log'.format(ctx.home()))


# helpers


def _create_cron_txt(*args, **kwargs):
  """
  renders a cron.txt template for the specified environ.
  """
  jinja_env = _load_jinja_env(dict(
    CRON_FILE='{}.template.txt'.format(CRON_FILE),
  ))

  context = env.config.copy()
  context.update(environ.get_host())

  for name, _ in jinja_env.loader.mapping.iteritems():
    _write_cron_txt(name, jinja_env.get_template(name), context)


def _load_jinja_env(templates):
  """
  creates a jinja environment for the cron.txt templates.

    :returns: instance of a `jinja2.Environment`
  """
  return Environment(loader=DictLoader(
    {name: str(open(path, 'r').read()) for name, path in templates.iteritems()}
  ))


def _write_cron_txt(name, template, context):
  """
  writes the file to disk.
  """
  contents = template.render(**context)

  print(blue('writing {}..'.format(name)))

  if env.env_id in ('local', 'test'):
    with open(name, 'w') as f:
      f.write(contents)

  else:
    with ctx.warn_only():
      execute('echo "{}" > {}'.format(escape(contents), name))


def escape(val):
  return val.replace('"', '\"')
