# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :gigalixir_helloworld,
  ecto_repos: [GigalixirHelloworld.Repo]

# Configures the endpoint
config :gigalixir_helloworld, GigalixirHelloworld.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WZ8bmi7RDhRjHVnbwdaOuoCk/o8Ijnd/N3MB440U43vZS3Q07aywtErv0wYQiehg",
  render_errors: [view: GigalixirHelloworld.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GigalixirHelloworld.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
