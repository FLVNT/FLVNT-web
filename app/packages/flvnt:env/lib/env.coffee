
process.env.ENV_ID = env_id
envs = {}


class Environ

  constructor: (id, options)->
    @id = id
    if options?.settings?
      @set_settings options.settings

  set_settings: (settings) ->
    _.extend @, JSON.parse(settings)

  url: (path)->
    if path?
      path = "/" + path
    else
      path = ""
    return @root_url + path


# localhost development server config
envs.local = new Environ('local')
# circle ci server config
envs.stage = new Environ('stage')
# production server config
envs.prod  = new Environ('prod')
# test server config
envs.test  = new Environ('test')


# export the env object that maps to the current environment id..
env = envs[env_id]

console.info "current environment:", env_id
