# encoding: utf-8
"""
  fab.npm
  ~~~~~~~

  fabric context for node package manager.

"""
from __future__ import unicode_literals
from pprint import pformat
from fabric.api import env
from fabric.colors import blue, green, red, yellow
from fabctx import ctx
from fab.environ import get_host
from fab.environ import task
from fab.utils import execute


__all__ = []
