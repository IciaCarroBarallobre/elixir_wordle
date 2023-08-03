ExUnit.start()
ExUnit.configure(exclude: [:wallaby])

# Mocking tests
Mox.defmock(ElixirWordle.WordsMock, for: ElixirWordle.WordsAPI)
Application.put_env(:elixir_wordle, :wordle_api, ElixirWordle.WordsMock)

# Sandbox
Ecto.Adapters.SQL.Sandbox.mode(ElixirWordle.Repo, :manual)

# Wallaby
{:ok, _} = Application.ensure_all_started(:wallaby)
Application.put_env(:wallaby, :screenshot_dir, "docs/images/screenshots")
Application.put_env(:wallaby, :base_url, ElixirWordleWeb.Endpoint.url())
