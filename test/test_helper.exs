Mox.defmock(ElixirWordle.WordleMock, for: ElixirWordle.WordleAPI)
Application.put_env(:elixir_wordle, :wordle_api, ElixirWordle.WordleMock)

ExUnit.start()
ExUnit.configure(exclude: [:wallaby, :slow_test])

# Wallaby
{:ok, _} = Application.ensure_all_started(:wallaby)
Application.put_env(:wallaby, :screenshot_dir, "docs/images/screenshots")
Application.put_env(:wallaby, :base_url, ElixirWordleWeb.Endpoint.url())
