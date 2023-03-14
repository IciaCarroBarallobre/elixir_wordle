defmodule ElixirWordle.WordleMock do
  @moduledoc """
    An implementation of a WordleBehaviour.

    That's mimicking the behavior of a Wordle server, which can communicate
    with a database to retrieve a word and also provide feedback on a guess.
  """
  @behaviour ElixirWordle.WordleBehaviour

  defp answer() do
    %{
      answer: "sigil",
      clue: "Mechanisms for working with textual representations"
    }
  end

  @impl ElixirWordle.WordleBehaviour
  def get_length_and_clue(),
    do:
      {:ok,
       %{
         length: String.length(answer().answer),
         clue: answer().clue
       }}

  @impl ElixirWordle.WordleBehaviour
  def feedback(guess),
    do:
      {:ok,
       %{
         guess: guess,
         feedback: for(_char <- 1..String.length(guess), do: :letter_match)
       }}
end
