ExUnit.start()
ExUnit.configure(exclude: :wallaby)

{:ok, _} = Application.ensure_all_started(:wallaby)
Application.put_env(:wallaby, :screenshot_dir, "docs/images/screenshots")
Application.put_env(:wallaby, :base_url, ElixirWordleWeb.Endpoint.url())
