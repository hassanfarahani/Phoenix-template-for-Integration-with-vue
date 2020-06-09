defmodule Widgets.Repo do
  use Ecto.Repo,
    otp_app: :widgets,
    adapter: Ecto.Adapters.Postgres
end
