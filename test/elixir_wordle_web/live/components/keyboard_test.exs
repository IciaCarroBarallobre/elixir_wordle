defmodule ElixirWordleWeb.KeyboardTest do
  use ExUnit.Case
  use ElixirWordleWeb.ConnCase

  use Wallaby.Feature

  import Mox

  setup :set_mox_from_context
  setup :verify_on_exit!

  @word_info %{
    word: "elixir",
    clue: "A language",
    description:
      "Elixir is a dynamic, functional language for building scalable and maintainable applications"
  }

  @tag :wallaby
  feature "JS Client test: screen keyboard works with inputs", %{session: session} do
    ElixirWordle.MockWordleAPI
    |> expect(:get_word_info, 2, fn -> {:ok, @word_info} end)

    session
    |> visit("/")
    |> click(Query.button("keyboard-A"))
    |> assert_text(Query.css("#input-1-1"), "A")
  end

  @tag :wallaby
  feature "JS Client test: external keyboard linked to screen keyboard", %{session: session} do
    ElixirWordle.MockWordleAPI
    |> expect(:get_word_info, 2, fn -> {:ok, @word_info} end)

    session |> visit("/") |> send_keys([:B]) |> assert_text(Query.css("#input-1-1"), "B")
  end
end
