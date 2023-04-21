defmodule ElixirWordle.WordsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirWordle.Words` context.
  """

  @doc """
  Generate a word.
  """
  def word_fixture(attrs \\ %{}) do
    {:ok, word} =
      attrs
      |> Enum.into(%{
        word: "example",
        clue: "this is the clue",
        description: "this is the description"
      })
      |> ElixirWordle.Words.create_word()

    word
  end
end
