# encoding: utf-8
"""
  fab.git
  ~~~~~~~

  fabric context for git + github.

"""
from __future__ import unicode_literals
from fabric.api import env
from fabric.api import run
from fabric.colors import blue
from fab.environ import task
from fabctx import ctx
from fab.utils import execute


__all__ = ['update']


@task
def update(host):
  """
  updates the application from git
  """
  print(blue("updating app from git.."))

  # TODO: change to execute() vs run() ..?

  with ctx.warn_only():
    run("git stash")

  with ctx.warn_only():
    run("git checkout {}".format(host['branch']))

  with ctx.warn_only():
    run("git pull origin {}".format(host['branch']))

  print(blue("app hotreloaded.."))
