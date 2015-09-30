# encoding: utf-8
"""
  fab.handler
  ~~~~~~~~~~~

  module to manage program exit + status codes.

"""
from __future__ import unicode_literals
from pprint import pformat
from fabric.colors import blue, green, red, yellow
import atexit
import signal


def signal_handler(*args, **kwargs):
  if len(args) > 1:
    print red( '\t * {}'.format(args) )

  if len(kwargs) > 1:
    print red( '\t * {}'.format(kwargs) )

  print pformat(env)
  for r in env.resources_log:
    print red( '\t * '.format(r) )


atexit.register(signal_handler)
#: note: this doesn't work at catching ctrl-c w/ multiprocessing code..
signal.signal(signal.SIGINT,  signal_handler)
signal.signal(signal.SIGTERM, signal_handler)
