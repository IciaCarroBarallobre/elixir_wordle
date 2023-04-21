defmodule ElixirWordle.Words do
  @moduledoc """
  The Entries context.
  """

  import Ecto.Query, warn: false
  alias ElixirWordle.Repo

  alias ElixirWordle.Words.Word

  @doc """
  Gets a single word if id exists in db, otherwise, nil.

  ## Examples

      iex> get_word(123)
      %Word{_}

      iex> get_word(456)
      nil

  """
  def get_word(id), do: Repo.get_by(Word, id: id)

  @doc """
  Creates a word.

  ## Examples

      iex> create_word(%{word: "example", clue: "this is the clue", description: "this is the description" })
      {:ok, %Word{_}}


      iex> create_word(%{
        word: "longestwordthanallowed", ç
        clue: "longestwordthanallowed appears in the clue" ,
        description: nil
      })
      {:error, %Ecto.Changeset{}}


  """
  def create_word(attrs \\ %{}) do
    %Word{}
    |> Word.changeset(attrs)
    |> Repo.insert()
  end
end
