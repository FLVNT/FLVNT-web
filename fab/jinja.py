# encoding: utf-8
"""
  fab.jinja
  ~~~~~~~~~

  user jinja2 for building configuration files.

"""
from __future__ import unicode_literals
from jinja2 import Environment
from jinja2.loaders import DictLoader
from fabric.api import env
from fabctx import ctx
# from fab.environ import *
from fab.environ import task
from fab.utils import execute
from fab.utils import puts


__all__ = ['env_dict', 'render']


def env_dict(key, value):
  """
  returns instance of jinja2.Environment with default jinja2.loaders.DictLoader
  property set.
  """
  if len(value) < 1:
    raise EnvironmentError("{} cannot be empty..".format(key))

  _loader = DictLoader({
    str(key): str(value),
  })

  return Environment(loader=_loader)


def render(template, context, out_path):
  """
  renders the jinja2 template, writes to the file to the specified out_path.

    :param template: instance of a jinja2 template object
    :param context: instance of a dict
    :param out_path: string file path
  """
  with open(out_path, 'w') as f:
    f.write(template.render(**context))
