# encoding: utf-8
"""
  fab.users
  ~~~~~~~~~

  module for env user fabric helpers.

"""
from __future__ import unicode_literals
from fabric.api import env
from fab.environ import task


__all__ = []


env.user_mongo_id = None
env.user_fbid = None
