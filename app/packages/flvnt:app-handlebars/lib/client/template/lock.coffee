
#: non-reactive helper to set a "lock" to prevent template events from firing..

Template.prototype.lock = ->
  @_locked = 1

Template.prototype.unlock = ->
  @_locked = null

#: returns true/false if the `template.lock` is 1
Template.prototype.locked = ->
  @_locked == 1

#: thrown an error to halt execution if `template.lock` is 1, otherwise
#: will set `template.lock` to 1
Template.prototype.exec_lock = ->
  if @_locked == 1
    throw new Meteor.Error('template is locked..')
  @_locked == 1


Blaze.TemplateInstance.prototype.lock = ->
  @_locked = 1

Blaze.TemplateInstance.prototype.unlock = ->
  @_locked = null

#: returns true/false if the `template.lock` is 1
Blaze.TemplateInstance.prototype.locked = ->
  @_locked == 1

#: thrown an error to halt execution if `template.lock` is 1, otherwise
#: will set `template.lock` to 1
Blaze.TemplateInstance.prototype.exec_lock = ->
  if @_locked == 1
    throw new Meteor.Error('template is locked..')
  @_locked == 1


# Blaze.TemplateInstance.prototype.lock = Template.prototype.lock
# Blaze.TemplateInstance.prototype.unlock = Template.prototype.unlock
# Blaze.TemplateInstance.prototype.locked = Template.prototype.locked
# Blaze.TemplateInstance.prototype.exec_lock = Template.prototype.exec_lock
