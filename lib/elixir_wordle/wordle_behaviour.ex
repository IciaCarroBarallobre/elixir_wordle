defmodule ElixirWordle.WordleBehaviour do
  @callback get_length_and_clue() :: {:ok, response :: map} | {:error, String.t()}
  @callback feedback(guess :: binary) :: {:ok, list} | {:error, any}
end
