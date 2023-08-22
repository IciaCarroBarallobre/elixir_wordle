defmodule ElixirWordle.Words do
  @moduledoc """
  The Words context.
  """

  import Ecto.Query, warn: false

  alias ElixirWordle.Repo
  alias ElixirWordle.Words.Word

  @behaviour ElixirWordle.WordsAPI

  @doc """
  todays_word/0 retrieves a word by ID, which is calculated using the remainder of today's day
  divided by total database rows to prevent selecting nonexistent numbers,
  considering incremental word IDs. If the word doesn't exist, it returns an error message.
  ## Examples

      iex> get_todays_word()
      {:ok, %Word{_}}

      iex> get_todays_word()
      {:error, "Today's word is not available"}

  """
  @impl ElixirWordle.WordsAPI
  def get_todays_word() do
    day = Date.day_of_year(Date.utc_today())
    available_words = Repo.one(from(w in "words", select: fragment("count(*)")))
    id= if available_words > 0, do: rem(day, available_words), else: -1

    case get_word(id) do
      %Word{word: word, clue: clue, description: description} ->
        {:ok, %{word: word, clue: clue, description: description}}

      _ ->
        {:error, "Today's word is not available"}
    end
  end

  @doc """
  Retrieves a word from the database if the ID exists, otherwise returns nil.

  ## Examples

      iex> get_word(123)
      %Word{_}

      iex> get_word(456)
      nil

  """
  def get_word(id), do: Repo.get_by(Word, id: id)

  @doc """
  If the changeset validations pass, this function creates a word.
  Otherwise, it returns the `:error` status along with the changeset containing error information.

  ## Examples

      iex> create_word(%{word: "example", clue: "this is the clue", description: "this is the description" })
      {:ok, %Word{_}}


      iex> create_word(%{
        word: "longestwordthanallowed",
        clue: "longestwordthanallowed appears in the clue" ,
        description: nil
      })
      {:error, %Ecto.Changeset{_}}


  """
  def create_word(attrs \\ %{}) do
    %Word{}
    |> Word.changeset(attrs)
    |> Repo.insert()
  end
end
