# encoding: utf-8
"""
  fab.notify
  ~~~~~~~~~~

  helpers + context for notifications.

"""
from __future__ import unicode_literals
from fabric.api import env, local
from fabctx import ctx, http
from fab.environ import task


__all__ = ['meteor_app_deployed', 'email', 'terminal']


def email(recipient, template_id):
  """
  sends a HTTP POST request to unvael's app-engine mail api.

    :param recipient:
    :param template_id:
  """
  data = env.config.copy()
  # set template context args..
  data['env_id'] = env.env_id
  data['recipient'] = recipient
  data['template_id'] = template_id
  http.post('http://gae.unvael.com/api/mail/send', data)


def terminal(msg):
  """
  ping the terminal prompt (osx only)..

    :param msg:
  """
  with ctx.quiet():
    local('say "{}"'.format(msg.replace('"', '\"')))


@task
def meteor_app_deployed(*args, **kwargs):
  """
  sends deployment notifications by email and terminal.
  """
  recipient = 'deployments-{id}@unvael.com'.format(**env.config)
  email(recipient, 'meteor-app-deployed')
  terminal('deployment completed')
