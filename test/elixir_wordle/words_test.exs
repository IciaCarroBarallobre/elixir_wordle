defmodule ElixirWordle.WordsTest do
  use ExUnit.Case, async: true

  import ElixirWordle.WordsFixtures

  alias ElixirWordle.Repo
  alias ElixirWordle.Words
  alias ElixirWordle.Words.Word

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "get_word/1" do
    test "get_word/1 returns the word for an existing id" do
      word = word_fixture()
      assert Words.get_word(word.id) == word
    end

    test "get_word/1 returns nil when id doesn't exist" do
      assert is_nil(Words.get_word(1))
    end
  end

  describe "create_word/1" do
    test "create_word/1 with valid data creates a word" do
      valid_attrs = %{
        word: "elixir",
        clue: "A language",
        description: "Elixir is a language, ..."
      }

      assert {:ok, %Word{} = post} = Words.create_word(valid_attrs)
      assert post.word == valid_attrs.word
      assert post.clue == valid_attrs.clue
      assert post.description == valid_attrs.description
    end

    test "create_word/1 with nil in required data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Words.create_word(%{})
    end

    test "create_word/1 with word in the clue returns error changeset" do
      attrs = %{word: "elixir", clue: "answer is elixir", description: "...."}

      assert {:error, %Ecto.Changeset{errors: errors}} = Words.create_word(attrs)
      assert Keyword.get(errors, :clue)
    end

    test "create_word/1 with word which has more length than 8 returns error changeset" do
      attrs = %{word: "thisisthelongestword", clue: "example", description: "example"}

      assert {:error, %Ecto.Changeset{errors: errors}} = Words.create_word(attrs)
      assert Keyword.get(errors, :word)
    end

    test "create_word/1 with word which has less length than 3 returns error changeset" do
      attrs = %{word: "a", clue: "example", description: "example"}

      assert {:error, %Ecto.Changeset{errors: errors}} = Words.create_word(attrs)
      assert Keyword.get(errors, :word)
    end

    test "create_word/1 with duplicated name returns error changeset" do
      word = word_fixture()
      attrs = %{word: word.word, clue: "sdfjka", description: "sdfjka"}

      assert {:error, %Ecto.Changeset{errors: errors}} = Words.create_word(attrs)
      assert Keyword.get(errors, :word)
    end

    test "create_word/1 when word contains not valid letters" do
      attrs = %{word: "15.ñ", clue: "sdfjka", description: "sdfjka"}

      assert {:error, %Ecto.Changeset{errors: errors}} = Words.create_word(attrs)
      assert Keyword.get(errors, :word)
    end
  end
end
