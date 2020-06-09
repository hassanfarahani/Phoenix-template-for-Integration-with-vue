# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :widgets,
  ecto_repos: [Widgets.Repo]

# Configures the endpoint
config :widgets, WidgetsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wUJCI8MeY7uKZq9NBs/gxYiLk4xyJCWvSiiCzGshl3oCo9eSBMaMceIG8sigwjT/",
  render_errors: [view: WidgetsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Widgets.PubSub,
  live_view: [signing_salt: "xK6IEeU0"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
