ESC_KEYCODE       = 27
TAB_KEYCODE       = 9
SHIFT_KEYCODE     = 16
CTRL_KEYCODE      = 17
ALT_KEYCODE       = 18
SPACE_KEYCODE     = 32
DELETE_KEYCODE    = 8
A_KEYCODE         = 65
C_KEYCODE         = 67
N_KEYCODE         = 78
R_ARROW_KEYCODE   = 39
L_ARROW_KEYCODE   = 37
U_ARROW_KEYCODE   = 38
D_ARROW_KEYCODE   = 40
O_ARROW_KEYCODE   = 79
DOT_KEYCODE       = 190
COMMA_KEYCODE     = 188
FWD_SLASH_KEYCODE = 191
QUESTION_KEYCODE  = "#{FWD_SLASH_KEYCODE}-shift"


#: create a mapping of key-handlers to component/modules to handle events
#: specific to each view/page/ui-state

UI_STATE_TO_KEY_HANLDER_MAP =
  group             : {}
  track_search      : {}
  create_track_post : {}
  groups            : {}
  groups_explore    : {}
  notifications_tab : {}


# TODO: replace keys with codes (above)..
KEY_TO_HANDLER_MAP =

  #: ESC_KEYCODE
  "27": (e)->
    return if e?.isDefaultPrevented()
    e.preventDefault()

  #: TAB_KEYCODE
  "9": (e)->
    return if e?.isDefaultPrevented()
    e.preventDefault()

  # DELETE
  "8": (e)->
    return if e?.isDefaultPrevented()
    e.preventDefault()

  # DOT
  "190": (e)->
    return if e?.isDefaultPrevented()
    e.preventDefault()

  # o-char
  "79": (e)->
    return if e?.isDefaultPrevented()
    e.preventDefault()


  # toggle player state

  "32": (e)->
    e?.preventDefault()
    $controls = $ '#player_controls'
    return unless $controls.length

    # cache playing state
    is_playing = Player.toggle_play()
    unless is_playing
      Player.goto_playing_group()
    false

  # create track post

  "65": (e)->
    show_add_track_post()
    e.preventDefault()
    false

  "67": (e)->
    show_add_track_post()
    e.preventDefault()
    false

  # toggle playlist control

  "40": (e)->
    $controls = $ '#player_controls'
    return unless $controls.length
    return if e.isDefaultPrevented()
    e?.preventDefault()

    logger.info "playing next track.."
    Player.next_track()
    Player.goto_playing_group()
    false

  "39": (e)->
    $controls = $ '#player_controls'
    return unless $controls.length
    return if e.isDefaultPrevented()
    e?.preventDefault()

    logger.info "playing next track.."
    Player.next_track()
    Player.goto_playing_group()
    false

  "38": (e)->
    $controls = $ '#player_controls'
    return unless $controls.length
    return if e.isDefaultPrevented()
    e.preventDefault()

    logger.info "playing previous track.."
    Player.prev_track()
    false

  "37": (e)->
    $controls = $ '#player_controls'
    return unless $controls.length
    return if e.isDefaultPrevented()
    e?.preventDefault()

    logger.info "playing previous track.."
    Player.prev_track()
    false

  #: handle global search

  "191": (e)->
    return if e.isDefaultPrevented()
    e?.preventDefault()
    if current_group()?
      logger.info "[HOTKEYS] opening group search modal.."
      # todo: trigger custom event for opening search modal
    else
      logger.info "[HOTKEYS] opening group / track-search modal.."
      # todo: trigger custom event for opening search modal
    false

  # FWD_SLASH_KEYCODE + SHIFT
  "191-shift": (e)->
    return if e.isDefaultPrevented()
    e?.preventDefault()
    logger.info "[HOTKEYS] opening help modal.."
    # todo: trigger custom event for opening search modal
    false


#: spacebar keyboard integration with the player controls
@handle_keydown = (e)->
  #: if there is no group loaded, then return early..
  # group = current_group()
  #  else if not group?
  #   return logger.warn('no group loaded..')

  #: make sure other modals arent open..
  # ----
  return true if $('body').hasClass 'modalized'

  #: return early if someone is typing in a form input field
  # ----
  $target = $ e.target
  node = $target[0].nodeName.toUpperCase()
  return true if node in ['INPUT', 'TEXTAREA', 'SELECT']

  code = "#{e.keyCode}"

  #: append shift / meta keys to the code to handle their events differently
  if e.shiftKey
    code = "#{code}-SHIFT"

  if e.metaKey
    code = "#{code}-META"

  return true unless KEY_TO_HANDLER_MAP[code]?
  KEY_TO_HANDLER_MAP[code](e)


# flag to prevent double-binding..
@hotkeys_bound = false

# bind spacebar event
@bind_hotkeys = ->
  return if hotkeys_bound
  logger.info 'binding '
  hotkeys_bound = true
  $('body').on 'keydown', handle_keydown

# unbind spacebar event
@unbind_hotkeys = ->
  $('body').off 'keydown', handle_keydown
  hotkeys_bound = false


Template.hotkeys.created = ->
  bind_hotkeys()

Template.hotkeys.onDestroyed = ->
  unbind_hotkeys()
