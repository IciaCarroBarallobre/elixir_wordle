defmodule ElixirWordleWeb.Wallaby.SnapshotTests do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  @tag :wallaby
  feature "wallaby screenshot", %{session: session} do
    responsive = [640, 768, 1024]

    home =
      session
      |> visit("/")

    responsive
    |> Enum.map(fn size ->
      take_screenshot(
        resize_window(home, size, 1020),
        name: "screenshot-w-#{size}"
      )
    end)
  end
end
