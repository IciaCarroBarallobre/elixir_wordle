defmodule ElixirWordleWeb.Wallaby.SnapshotTests do
  use ExUnit.Case
  use Wallaby.Feature

  import Mox

  setup :set_mox_from_context
  setup :verify_on_exit!

  @height 844
  @responsive_width [sm: 640, md: 768, lg: 1024]

  @tag :wallaby
  feature "wallaby screenshot when answer has a supported length", %{session: session} do
    ElixirWordle.MockWordleAPI
    |> expect(:get_length_and_clue, 2, fn -> {:ok, %{length: 5, clue: "This is the clue"}} end)

    home = session |> visit("/")

    @responsive_width
    |> Enum.map(fn {_name, width} ->
      take_screenshot(resize_window(home, width, @height), name: "screenshot-w-#{width}")
    end)
  end

  @tag :wallaby
  feature "wallaby screenshot when answer is unavailable", %{session: session} do
    ElixirWordle.MockWordleAPI
    |> expect(:get_length_and_clue, 2, fn -> {:error, "Not available"} end)

    home = session |> visit("/")

    @responsive_width
    |> Enum.map(fn {_name, width} ->
      take_screenshot(
        resize_window(home, width, @height),
        name: "screenshot-w-unavailable-word-#{width}"
      )
    end)
  end

  @tag :wallaby
  feature "wallaby screenshot for instructions", %{session: session} do
    ElixirWordle.MockWordleAPI
    |> expect(:get_length_and_clue, 2, fn -> {:ok, %{length: 5, clue: ""}} end)

    home =
      session
      |> visit("/")
      |> click(Query.button("button-wordle-rules"))

    @responsive_width
    |> Enum.map(fn {_name, width} ->
      take_screenshot(
        resize_window(home, width, @height),
        name: "screenshot-w-instructions-#{width}"
      )
    end)
  end
end
