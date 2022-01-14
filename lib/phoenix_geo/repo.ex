defmodule PhoenixGeo.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_geo,
    adapter: Ecto.Adapters.Postgres
end
