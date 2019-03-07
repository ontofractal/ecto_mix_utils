defmodule EctoMixUtils.Repo do
  use Ecto.Repo,
    otp_app: :ecto_mix_utils,
    adapter: Ecto.Adapters.Postgres
end
