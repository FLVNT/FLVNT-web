# encoding: utf-8
"""
  fab.laika
  ~~~~~~~~~

  context for laika.

"""
from __future__ import unicode_literals
from pprint import pformat
from fabric.api import env
from fabric.api import local
from fab.environ import task
from fabric.colors import blue, green, red, yellow
from fabctx import ctx
from fab import mongo
from fab import supervisord
from fab.meteor import meteor_shell
from fab.utils import execute
from fab.utils import puts


__all__ = ['meteor', 'laika_shell', 'install']


@ctx.contextmanager
def laika_shell(**kwargs):
  """
  sets the shell context for the laika test runner.
  """
  with meteor_shell():
    _setup()
    try:
      yield
    except Exception, e:
      puts(red(' ---> {}'.format(e)))
    finally:
      _teardown()


@task
def install(*args, **kwargs):
  """
  installs the laika test runner framework + dependencies.
  """
  with meteor_shell():
    with ctx.warn_only():
      execute("npm install -g laika coffee-script")


def _setup():
  """
  setup test environment.
  """
  puts(blue('\n ---> laika: setup..\n'))

  with ctx.warn_only():
    supervisord.start()

  mongod.start('test')


def _teardown():
  """
  teardown test environment.
  """
  puts(blue('\n ---> laika: teardown..\n'))
  # stop mongodb
  with ctx.warn_only():
    mongo.stop('test')

  with ctx.warn_only():
    supervisord.stop()

  with ctx.quiet():
    execute('killall phantomjs')


@task
def meteor(*args, **kwargs):
  """
  runs the laika test runner.
  """
  _ctx = env.config.copy()

  flags = dict(
    verbose   = 1,
    settings  = './private/env-{id}.json'.format(**_ctx),
    # TODO: stylus, jade.. ?
    compilers = ' coffee:coffee-script/register ',
  )

  with laika_shell():
    with ctx.warn_only():
      execute(
        'laika --compilers coffee:coffee-script/register '
        '--settings ./private/env-{id}.json '
        '--verbose '.format(**_ctx),
      )
