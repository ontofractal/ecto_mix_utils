use Mix.Config

config :ecto_mix_utils, EctoMixUtils.Repo,
  database: "ecto_mix_utils_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool_size: 25
