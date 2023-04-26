defmodule ElixirWordleWeb.Wallaby.SnapshotTests do
  use ExUnit.Case
  use Wallaby.Feature

  import Mox

  setup :set_mox_from_context
  setup :verify_on_exit!

  @height 844
  @responsive_width [sm: 640, md: 768, lg: 1024]

  @word_info %{
    word: "elixir",
    clue: "A language",
    description:
      "Elixir is a dynamic, functional language for building scalable and maintainable applications"
  }

  @tag :wallaby
  feature "wallaby screenshot when answer has a supported length", %{session: session} do
    ElixirWordle.MockWordsAPI
    |> expect(:get_todays_word, 2, fn -> {:ok, @word_info} end)

    home = session |> visit("/")

    @responsive_width
    |> Enum.map(fn {_name, width} ->
      take_screenshot(resize_window(home, width, @height), name: "screenshot-w-#{width}")
    end)
  end

  @tag :wallaby
  feature "wallaby screenshot when answer is unavailable", %{session: session} do
    ElixirWordle.MockWordsAPI
    |> expect(:get_todays_word, 2, fn -> {:error, "Not available"} end)

    home = session |> visit("/")

    @responsive_width
    |> Enum.map(fn {_name, width} ->
      take_screenshot(
        resize_window(home, width, @height),
        name: "screenshot-unavailable-word-w-#{width}"
      )
    end)
  end

  @tag :wallaby
  feature "wallaby screenshot for rules", %{session: session} do
    ElixirWordle.MockWordsAPI
    |> expect(:get_todays_word, 2, fn -> {:ok, @word_info} end)

    home =
      session
      |> visit("/")
      |> click(Query.button("button-wordle-rules"))

    @responsive_width
    |> Enum.map(fn {_name, width} ->
      take_screenshot(
        resize_window(home, width, @height),
        name: "screenshot-rules-w-#{width}"
      )
    end)
  end

  @tag :wallaby
  feature "wallaby screenshot for results", %{session: session} do
    ElixirWordle.MockWordsAPI
    |> expect(:get_todays_word, 2, fn -> {:ok, @word_info} end)

    word = String.upcase(@word_info.word)

    keys =
      for letter <- word |> String.split("", trim: true) do
        String.to_atom(letter)
      end

    home =
      session
      |> visit("/")
      |> send_keys(keys)
      |> send_keys([:enter])
      |> click(Query.button("button-results"))

    @responsive_width
    |> Enum.map(fn {_name, width} ->
      take_screenshot(
        resize_window(home, width, @height),
        name: "screenshot-results-w-#{width}"
      )
    end)
  end
end
