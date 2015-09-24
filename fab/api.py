# encoding: utf-8
"""
  fab.api
  ~~~~~~~

  method decorator run a fabric task ensuring set_env wraps the inner call

"""
from __future__ import unicode_literals
from functools import wraps
from fab.environ import task


__all__ = ['task']

