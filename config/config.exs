# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :waifu_claiming,
  ecto_repos: [WaifuClaiming.Repo]

# Configures the endpoint
config :waifu_claiming, WaifuClaimingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tA1hFsKMBqnMixBlRgD4Pg3du2oRil2NiTTEjWZWw93ydvOWd8ewTD21pscTPq0r",
  render_errors: [view: WaifuClaimingWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WaifuClaiming.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ueberauth, Ueberauth,
  providers: [
    facebook: {Ueberauth.Strategy.Facebook, []}
  ]

config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: System.get_env("FACEBOOK_CLIENT_ID"),
  client_secret: System.get_env("FACEBOOK_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
