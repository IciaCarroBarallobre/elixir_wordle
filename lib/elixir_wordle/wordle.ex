defmodule ElixirWordle.Wordle do
  @behaviour ElixirWordle.WordleAPI

  @moduledoc """
  Wordle Module can check how many exact matches, same position and letter,
  occurrences, same letter, or no matches are between a word (``answer``)
  and another word (``guess``). Uppercase and lowercase do not matter at all.
  - Exact matches => ``:match``
  - Matches/Occurrences => ``:letter_match``
  - No matches => ``:fail``
  Prioritizing exact matches, and then, prioritizing first appearances.
  Both words have to contains same length and use only UTF-8 characters.
  """

  defp answer() do
    %{
      answer: "sigil",
      clue: "Mechanisms for working with textual representations",
      description:
        "Sigils start with the tilde (~) character which is followed by a letter and then a delimiter.
       Common sigils: ~r regex expressions, ~c charlist, ~s strings, ~w  lists of words,
       ~D date, ~T time etc."
    }
  end

  @impl ElixirWordle.WordleAPI
  def get_word_info(),
    do:
      {:ok,
       %{
         answer: answer().answer,
         clue: answer().clue,
         description: answer().description
       }}

  @impl ElixirWordle.WordleAPI
  def feedback(guess, answer)

  @doc """
  Compare answer with a guess.
  Returning a list which...
  - Exact matches are represented as ``[:match]``.
  - Occurrences are represented as ``[:letter_match]`` (prioritizing first appearances).
  - No matches are represented as ``[:fail]``.
  Uppercase and lowercase do not matter at all.
  Return an ``error`` if answer and gray are not binary with same length.

  ## Examples

      iex> Wordle.feedback("green", "grnne")
      {:ok, %{feedback: [:match, :match, :letter_match, :fail, :letter_match], guess: "green"}}

      iex> Wordle.feedback("greed", "green")
      {:ok, %{feedback: [:match, :match, :match, :match, :fail], guess: "greed"}}

      iex> Wordle.feedback("greed", 1)
      {:error, "Both arguments have to be strings."}

      iex> Wordle.feedback("greed", "aaaaaaaaaaaaaaaaaa")
      {:error, "Guess and answer must have the same number of letters."}
  """
  def feedback(guess, answer) when is_binary(guess) and is_binary(answer) do
    answer_list = answer |> String.downcase() |> String.to_charlist()
    guess_list = guess |> String.downcase() |> String.to_charlist()

    if String.length(answer) == String.length(guess) do
      result =
        guess_list
        |> check_matches(answer_list)
        |> check_occurrences(answer_list)
        |> no_matches()

      {:ok, %{guess: guess, feedback: result}}
    else
      {:error, "Guess and answer must have the same number of letters."}
    end
  end

  def feedback(_guess, _answer) do
    {:error, "Both arguments have to be strings."}
  end

  defp check_matches(guess, answer) do
    for {g, a} <- Enum.zip(guess, answer), do: if(g == a, do: :match, else: g)
  end

  defp check_occurrences(guess, answer) do
    occurrences = for {g, a} <- Enum.zip(guess, answer), !is_atom(g), do: a

    {_, result} =
      Enum.reduce(
        guess,
        {occurrences, []},
        fn guess_letter, {occurrences, result} ->
          if Enum.member?(occurrences, guess_letter) do
            {occurrences -- [guess_letter], [:letter_match | result]}
          else
            {occurrences, [guess_letter | result]}
          end
        end
      )

    result |> Enum.reverse()
  end

  defp no_matches(guess) do
    Enum.map(guess, fn x -> if is_atom(x), do: x, else: :fail end)
  end
end
