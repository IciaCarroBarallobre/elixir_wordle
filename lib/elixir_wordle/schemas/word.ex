defmodule ElixirWordle.Words.Word do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
  Each word consists of a word with a length ranging from 3 to 8 letters in lowercase,
  accompanied by a clue related to the word, and an optional description.
  """

  schema "words" do
    field(:clue, :string)
    field(:description, :string)
    field(:word, :string)

    timestamps()
  end

  @doc false
  def changeset(word, attrs) do
    word
    |> cast(attrs, [:word, :clue, :description])
    |> update_change(:word, &String.downcase(&1))
    |> validate_required([:word, :clue, :description])
    |> validate_length(:word, min: 3, max: 8)
    |> validate_format(
      :word,
      ~r/^[a-z]+$/,
      message: "has invalid format, it contains no-letter or capitalize characters"
    )
    |> validate_change(:clue, fn :clue, clue ->
      if attrs.word in split_in_words(clue), do: [clue: "clue contains the word"], else: []
    end)
    |> unique_constraint(:word)
  end

  defp split_in_words(text),
    do: text |> String.downcase() |> String.split([" ", ".", ","], trim: true)
end
