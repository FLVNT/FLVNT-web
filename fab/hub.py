# encoding: utf-8
"""
  fab.hub
  ~~~~~~~

  fabric for git-hub.

  see: https://github.com/defunkt/hub

"""
from __future__ import unicode_literals
from pprint import pformat
from fabric.api import env
from fabric.api import run
from fabric.colors import blue, green, red, yellow
from fabctx import ctx
from fab.environ import get_host
from fab.environ import task
from fab.environ import prefix_cd_approot
from fab.utils import execute
from fab.utils import puts
from fab import git
from fab import notify


__all__ = ['install', 'create_pull_request',]


@task
def install(*args, **kwargs):
  """
  installs git-hub via homebrew
  """
  puts(blue( "\ninstalling git-hub.." ))

  execute('brew install hub')

  puts(green( " ---> hub installed via homebrew.." ))


@task
def create_pull_request(target_branch=None, target_remote=None, *args, **kwargs):
  """
  creates a pull request on github.com
  """
  host = get_host()

  if target_branch is None or len(target_branch) < 1:
    target_branch = "develop"

  if target_remote is None or len(target_remote) < 1:
    target_remote = git.target_remote()

  current_remote = git.current_remote()
  if len(current_remote) < 1:
    current_remote = target_remote

  current_branch = git.current_branch()

  pr_title = _default_pr_title("${remote}:${target_branch}" "${remote}:${branch}".format(
    remote=current_remote,
    branch=current_branch,
    target_branch=target_branch))
  shstr = """hub pull-request -b ${target} -h ${current} "${pr_title}" """


def _default_pr_title(current, target):
  return "requesting a pull to ${target} from ${current}".format(
    current_branch=current_branch,
    target_branch=target_branch)
