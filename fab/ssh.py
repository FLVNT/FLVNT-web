# encoding: utf-8
"""
  fab.ssh
  ~~~~~~~

  fabric context for ssh.

"""
from __future__ import unicode_literals
from pprint import pformat
from fabric.api import env
from fabric.api import local
from fabric.colors import blue, green, red, yellow
from fabctx import ctx
from fab.environ import get_host
from fab.environ import task
from fab.utils import execute


__all__ = ['install_hostnames', 'shell']


@task
def install_hostnames(*args, **kwargs):
  """
  installs ssh hostnames to local ~/.ssh/config
  """

  _host_template = """
# {hostname}
# instance: {host_instance_type}  id: {host_instance_id}
# elb: ec2-xx-xxx-xxx-xxx.us-west-2.compute.amazonaws.com
# created:  {timestamp}
Host {hostname}
    identityfile ~/.ssh/keypairs/flvnt-web.pem
    user ubuntu
    ForwardAgent yes
    hostname {hostname_ip}
  """
  _ctx = get_host()
  _host_text = _host_template.format(**_ctx)

  print blue('\ninstalling host:\n\n{}'.format(_host_text))

  with open('~/.ssh/confg', 'w') as f:
    f.appendLine(_host_text)

  print green(' ---> ssh hostname installed: {hostname}..'.format(**_ctx))


@task
def shell(*args, **kwargs):
  """
  ssh onto the ec2 machine for a specified environ id.
  """
  local('ssh {hostname}'.format(**get_host()))
