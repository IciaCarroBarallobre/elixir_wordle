defmodule ElixirWordle.WordleAPI do
  @moduledoc """
  Wordle behaviour API
  """
  @callback get_word_info() :: {:ok, map} | {:error, String.t()}
  @callback feedback(guess :: String.t(), answer :: String.t()) ::
              {:ok, map} | {:error, String.t()}
end
