# encoding: utf-8
"""
  fab.tinytest
  ~~~~~~~~~~~~

  helpers for running meteor TinyTest.

"""
from __future__ import unicode_literals
from fabric.api import env
from fabric.api import cd, lcd
from fabric.colors import red, green
from fabctx import ctx
from fab import meteor
from fab.environ import task
from fab.utils import execute
from fab.utils import puts


__all__ = ['setup', 'teardown', 'run']



def setup(*args, **kwargs):
  '''
  setup tinytest
  '''


def teardown(*args, **kwargs):
  '''
  teardown tinytest
  '''


@task
def run(name=None, *args, **kwargs):
  """
  runs the meteor TinyTest runner.
  """
  teardown()
  setup()
  with meteor.meteor_shell():
    with ctx.warn_only():
      if name is not None:
        rv = execute('meteor test-packages ./packages/{}'.format(name))
      else:
        rv = execute('meteor test-packages')
  teardown()
