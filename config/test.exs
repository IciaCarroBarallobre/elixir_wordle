import Config
# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :elixir_wordle, ElixirWordle.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "elixir_wordle_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :elixir_wordle, ElixirWordleWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "NPQHb+6wTgzKULFnzHYOTw4tRmEuJL5beeS9BvQj1I7LtgryNcdVH6ZcAlea8vhs",
  server: true

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Chrome wallaby config
config :wallaby,
  driver: Wallaby.Chrome,
  screenshot_dir: "docs/images/screenshots"

# Behaviour for Wordle
config :elixir_wordle, :words_api, ElixirWordle.MockWordsAPI

# End results delay to 0
config :elixir_wordle, :display_results_delay, 0
