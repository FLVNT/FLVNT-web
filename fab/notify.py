# encoding: utf-8
"""
  fab.notify
  ~~~~~~~~~~

  helpers + context for notifications.

"""
from __future__ import unicode_literals
from pprint import pformat
from fabric.api import env, local
from fabric.colors import blue, green, red, yellow
from fabctx import ctx, http
from fab.environ import get_host
from fab.environ import task
from fab.utils import execute


__all__ = ['meteor_app_deployed', 'email', 'terminal']


def email(recipient, template_id):
  """
  sends a HTTP POST request to google's app-engine mail api.

    :param recipient:
    :param template_id:
  """
  _ctx = env.config.copy()
  # set template context args..
  _ctx['env_id'] = env.env_id
  _ctx['recipient'] = recipient
  _ctx['template_id'] = template_id
  http.post('http://gae.flvnt.com/api/mail/send', _ctx)


def terminal(msg):
  """
  ping the terminal prompt (osx only)..

    :param msg: string message body
  """
  with ctx.quiet():
    local('say "{}"'.format(msg.replace('"', '\"')))


@task
def meteor_app_deployed(*args, **kwargs):
  """
  sends deployment notifications by email + terminal
  """
  recipient = '{app_id}-deployments-{id}@flvnt.com'.format(**env.config)
  email(recipient, 'meteor-app-deployed')
  terminal('deployment completed')
