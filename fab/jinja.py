# encoding: utf-8
"""
  fab.jinja
  ~~~~~~~~~

  user jinja2 for building configuration files.

"""
from __future__ import unicode_literals
from fabctx import ctx
from fab.utils import execute
from fab.environ import *
from jinja2 import Environment
from jinja2.loaders import DictLoader
from fabric.api import env
from fab.environ import task


__all__ = []
