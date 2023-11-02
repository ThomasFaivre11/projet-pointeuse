# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :users_api,
  ecto_repos: [UsersApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :users_api, UsersApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+eYycw7WGsK0e7ZdUFDBXtpwHmZBPrQwlq9RJVwDyqrz6U4Kfn33Ly1Jtsu3ZrfR",
  render_errors: [view: UsersApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: UsersApi.PubSub,
  live_view: [signing_salt: "y+GlPKVT"]

config :cors_plug,
origins: ["http://localhost:3000"],
max_age: 86400,
methods: ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"],
headers: ["content-type", "authorization", "accept", "x-requested-with"]
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :users_api, UsersApi.Auth.Guardian,
  issuer: "users_api",
  secret_key: "XTs8TcBV28ttg3jqN6f9/I8/sPc1JvO8/L5RqYob9LKMd6ES1i6O+tm871jRIAXO"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
