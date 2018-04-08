use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gigalixir_helloworld, GigalixirHelloworld.Endpoint,
  http: [port: 4001],
  server: false

config :bcrypt_elixir, log_rounds: 4

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :gigalixir_helloworld, GigalixirHelloworld.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "gigalixir_helloworld_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
