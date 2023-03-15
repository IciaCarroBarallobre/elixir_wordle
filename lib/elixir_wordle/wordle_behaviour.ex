defmodule ElixirWordle.WordleBehaviour do
  @moduledoc """
  Wordle behaviour API
  """
  @callback get_length_and_clue() :: {:ok, response :: map} | {:error, String.t()}
  @callback feedback(guess :: binary) :: {:ok, map} | {:error, any}
end
