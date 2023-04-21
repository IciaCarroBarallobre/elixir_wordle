defmodule ElixirWordle.Repo do
  use Ecto.Repo,
    otp_app: :elixir_wordle,
    adapter: Ecto.Adapters.Postgres
end
