defmodule ElixirWordle.Wordle do
  @moduledoc """
  The Wordle module allow you to `play/2` wordle giving a game struct and a guess.
  The `%Wordle{}` game struct requires the `answer` to the word to be guessed.
  By default, the number of `attempts` allowed is 6.

  As the player makes guesses, the game structure accumulates them along with feedback.
  Feedback is provided in three categories:
  - `:match` when the current letter matches in its position,
  - `:letter_match` when the current letter occurs in the answer but in a different position,
  - `:fail` when the current letter is not present in the answer at all.

  The game ends either when the player runs out of attempts or
  when they successfully guess the answer.

  ## Examples

   iex> Wordle.play(%Wordle{answer: "ay"}, "ay")
   {:ok,
   %ElixirWordle.Wordle{
     answer: "ay",
     clue: nil,
     description: nil,
     win?: true,
     guesses: [{"ay", [:match, :match]}],
     attempts: 5
   }}

   iex> Wordle.play(%ElixirWordle.Wordle{answer: "example"}, "ey")
   {:error, "Not enough letters"}

   iex> Wordle.play(%Wordle{answer: "ay", win?: true}, "ey")
   {:error, "There aren't more attempts"}

   iex> Wordle.play(%Wordle{answer: "ay", attempts: 0}, "yy")
   {:error, "There aren't more attempts"}
  """

  @enforce_keys [:answer]
  defstruct [:answer, :clue, :description, win?: false, guesses: [], attempts: 6]
  defguard is_end?(attempts, win) when attempts == 0 or win

  defguard is_bigger?(guess, answer) when byte_size(guess) > byte_size(answer)
  defguard is_smaller?(guess, answer) when byte_size(guess) < byte_size(answer)
  defguard are_string?(guess, answer) when is_binary(guess) and is_binary(answer)

  def play(%{attempts: attempts, win?: win}, _guess) when is_end?(attempts, win),
    do: {:error, "There aren't more attempts"}

  def play(game, guess) do
    case feedback(guess, game.answer) do
      {:ok, %{guess: guess, feedback: guess_feedback}} ->
        {
          :ok,
          %{
            game
            | guesses: [{guess, guess_feedback} | game.guesses],
              attempts: game.attempts - 1,
              win?: is_win?(guess_feedback)
          }
        }

      {:error, msg} ->
        {:error, msg}
    end
  end

  def is_end?(game), do: is_end?(game.attempts, game.win?)

  def is_lost?(game), do: game.attempts == 0 and not game.win?

  def is_win?(feedback),
    do: Enum.all?(feedback, fn letter_feedback -> letter_feedback == :match end)

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
      {:error, "Not enough letters"}

      iex> Wordle.feedback("aaaaaaaaaaaaaaaaaa", "greed")
      {:error, "Too many letters"}
  """
  def feedback(guess, answer) when are_string?(guess, answer) and is_bigger?(guess, answer),
    do: {:error, "Too many letters"}

  def feedback(guess, answer) when are_string?(guess, answer) and is_smaller?(guess, answer),
    do: {:error, "Not enough letters"}

  def feedback(guess, answer) when are_string?(guess, answer) do
    answer_list = answer |> String.downcase() |> String.to_charlist()
    guess_list = guess |> String.downcase() |> String.to_charlist()

    {:ok,
     %{
       guess: guess,
       feedback:
         guess_list
         |> check_matches(answer_list)
         |> check_occurrences(answer_list)
         |> no_matches()
     }}
  end

  def feedback(_guess, _answer), do: {:error, "Both arguments have to be strings."}

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
