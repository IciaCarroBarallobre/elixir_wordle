defmodule ElixirWordle.WordleAPI do
  @moduledoc """
  Wordle behaviour API
  """
  @callback get_length_and_clue() :: {:ok, map} | {:error, String.t()}
  @callback feedback(guess :: String.t()) :: {:ok, map} | {:error, String.t()}

end
