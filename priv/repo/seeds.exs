# Script For Populating The Database.
# You Can Run It As:
#
# mix run priv/repo/seeds.exs
#
# Run in fly.io:
# fly ssh console --pty -C "/app/bin/elixir_wordle remote"
# ElixirWordle.Seed.seeding()

alias ElixirWordle.Seed

Seed.seeding()
