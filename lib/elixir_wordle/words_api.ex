defmodule ElixirWordle.WordsAPI do
  @moduledoc """
  Words behaviour API
  """
  @callback get_todays_word() ::
              {:ok, %{word: String.t(), clue: String.t(), description: String.t()}}
              | {:error, String.t()}
end
