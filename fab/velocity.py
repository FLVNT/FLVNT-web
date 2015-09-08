# encoding: utf-8
"""
  fab.velocity
  ~~~~~~~~~~~~

  fabric context for velocity.

"""
from __future__ import unicode_literals
from fabric.api import env
from fabric.api import local
from fab.environ import task
from fabric.colors import red, green
from fabctx import ctx
from fab import mongo
from fab.meteor import meteor_env, meteor_shell
from fab.utils import execute


__all__ = ['meteor', 'velocity_shell', 'setup', 'teardown', 'install']


@ctx.contextmanager
def velocity_shell(**kwargs):
  """
  sets the shell context for the velocity test runner.
  """
  with meteor_shell():
    _env = meteor_env()
    _env.update({
      'DEBUG': '1',
      'JASMINE_DEBUG': '1',
      'VELOCITY_DEBUG': '1',
      'VELOCITY_DEBUG_MIRROR': '1',
    })
    with ctx.shell_env(**_env):
      setup()
      try:
        print(green('FUCK'))
        yield
      except Exception, e:
        print(red(' ---> {}'.format(e)))
        raise e
      finally:
        teardown()


@task
def install(*args, **kw):
  """
  install velocity test runner
  """


@task
def setup(*args, **kw):
  """
  setup velocity test runner
  """


@task
def teardown(*args, **kw):
  """
  teardown velocity test runner
  """


@task
def meteor(*args, **kwargs):
  """
  runs the velocity test runner.
  """
  with velocity_shell():
    with ctx.warn_only():
      execute(
        'meteor --test '
        '--release velocity:{meteor_release_version} '
        '--settings ./private/env-{id}.json '
        '--raw-logs '
        '--verbose '.format(**env.config),
      )
