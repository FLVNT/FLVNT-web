
# ENV_ID environment variable. defaults to "local"
if process?.env?.ENV_ID?.length
  env_id = process.env.ENV_ID

else
  env_id = "local"
