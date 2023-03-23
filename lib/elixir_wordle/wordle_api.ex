defmodule ElixirWordle.WordleAPI do
  @moduledoc """
  Wordle behaviour API
  """
  @callback get_length_and_clue() :: {:ok, map} | {:error, String.t()}
  @callback feedback(guess :: String.t()) :: {:ok, map} | {:error, String.t()}

  def get_length_and_clue(), do: impl().get_length_and_clue()
  def feedback(guess), do: impl().feedback(guess)

  defp impl do
    Application.get_env(:elixir_wordle, :wordle_api, ElixirWordle.Wordle) ||
      raise("Missing configuration for WordleAPI.")
  end
end
