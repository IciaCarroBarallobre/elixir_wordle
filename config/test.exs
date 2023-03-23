import Config

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
config :elixir_wordle, :wordle_api, ElixirWordle.MockWordleAPI
