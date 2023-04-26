defmodule ElixirWordleWeb.WordleLiveTest do
  use ExUnit.Case
  use ElixirWordleWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import Mox

  setup :verify_on_exit!

  @word_info %{
    word: "erlang",
    clue: "A language",
    description: "Erlang is a general-purpose programming language and runtime environment.
          Erlang has built-in support for concurrency, distribution and fault tolerance."
  }

  @max_attempts 6

  describe "mount" do
    test "when the word cannot be obtained, the word is considered unavailable in the view", %{conn: conn} do

      ElixirWordle.MockWordsAPI
      |> expect(:get_todays_word, 2, fn -> {:error, "There is an error"} end)

      assert {:ok, view, html} = live(conn, "/")
      assert view |> element("#image_error") |> render() =~ "Word not available"
      assert view |> element("#clue") |> render() =~ "Today&#39;s word is not available"

      # When word is not available, board is not displayed
      refute html =~ "guesses-board"
      refute html =~ "inputs-board"
    end

    test "when the word doesn't have a supported length, the word is considered unavailable in the view",
         %{conn: conn} do
      ElixirWordle.MockWordsAPI
      |> expect(:get_todays_word, 2, fn ->
        {:ok, %{word: "ab", clue: "This is the clue", description: ""}}
      end)

      # When word is not available, set image error and warning at clue
      assert {:ok, view, html} = live(conn, "/")
      assert view |> element("#image_error") |> render() =~ "Word not available"

      clue_html = view |> element("#clue") |> render()
      assert clue_html =~ "Today&#39;s word is not available"

      # When word is not available, board is not displayed
      refute html =~ "guesses-board"
      refute html =~ "inputs-board"
    end

    test "when the word has a supported length, both the input board and the clue are set",
         %{conn: conn} do
      ElixirWordle.MockWordsAPI
      |> expect(:get_todays_word, 2, fn -> {:ok, @word_info} end)

      assert {:ok, view, _html} = live(conn, "/")

      # Set the clue & the input board with maximum number attempts
      assert view |> element("#clue") |> render() =~ @word_info.clue

      columns = String.length(@word_info.word)
      inputs_html = view |> element("#inputs-board") |> render()

      assert inputs_html
             |> String.contains?([
               "input-1-1",
               "input-1-#{columns}",
               "input-6-1",
               "input-6-#{columns}"
             ])
    end
  end

  describe "submit (when there are more attempts)" do
    test "when the guess is not the answer but has the same length, the guess will be shown at the guess board",
         %{conn: conn} do
      ElixirWordle.MockWordsAPI
      |> expect(:get_todays_word, 2, fn -> {:ok, @word_info} end)

      assert {:ok, view, _html} = live(conn, "/")

      # Submit a right length guess, which has to be displayed on the guesses board
      guess = "gnalre"
      render_hook(view, :submit, %{guess: guess})
      assert view |> element("#guesses-board") |> render() =~ guess

      # Now, there are 5 inputs attempts left
      assert view |> element("#inputs-board") |> render() =~ "input-5-"
      refute view |> element("#inputs-board") |> render() =~ "input-6-"
    end

    test "when the guess has less length than the answer, a message will be displayed",
         %{conn: conn} do
      ElixirWordle.MockWordsAPI
      |> expect(:get_todays_word, 2, fn -> {:ok, @word_info} end)

      assert {:ok, view, _html} = live(conn, "/")

      guess = "el"
      render_hook(view, :submit, %{guess: guess})
      refute view |> element("#guesses-board") |> render() =~ guess
      assert view |> element("#warningMessage") |> render() =~ "Not enough letters"
    end

    test "when the guess has more length than the answer, a message will be displayed",
         %{conn: conn} do
      ElixirWordle.MockWordsAPI
      |> expect(:get_todays_word, 2, fn -> {:ok, @word_info} end)

      assert {:ok, view, _html} = live(conn, "/")

      guess = "erlangss"
      render_hook(view, :submit, %{guess: guess})
      refute view |> element("#guesses-board") |> render() =~ guess
      assert view |> element("#warningMessage") |> render() =~ "Too many letters"

    end
  end

  describe "submit (when there aren't more attempts)" do
    test "when you accurately guess the word, then there's no more attempts", %{conn: conn} do
      ElixirWordle.MockWordsAPI
      |> expect(:get_todays_word, 2, fn -> {:ok, @word_info} end)

      assert {:ok, view, _html} = live(conn, "/")
      render_hook(view, :submit, %{guess: @word_info.word})

      # The word is set at guesses-board & the congratulation message is displayed
      assert view |> element("#guesses-board") |> render() =~ @word_info.word
      assert view |> element("#warningMessage") |> render() =~ "You won !"

      # Attempting to submit another guess when there are no more attempts, it display a warning message
      word = "rtasmh"
      render_hook(view, :submit, %{guess: word})
      assert view |> element("#warningMessage") |> render() =~ "There aren&#39;t more attempts"
      refute view |> element("#guesses-board") |> render() =~ word
    end

    test "when you exhaust the max number of attempts, a message will be displayed", %{conn: conn} do
      ElixirWordle.MockWordsAPI
      |> expect(:get_todays_word, 2, fn -> {:ok, @word_info} end)

      assert {:ok, view, _html} = live(conn, "/")

      # Exhaust attempts
      for _i <- 1..@max_attempts, do: render_hook(view, :submit, %{guess: "gnalre"})
      assert view |> element("#warningMessage") |> render() =~ "You lost !"
      refute view |> element("#inputs-board") |> render() =~ "input-1-1"

      # Attempting to submit another guess when there are no more attempts
      word = "irling"
      render_hook(view, :submit, %{guess: word})
      assert view |> element("#warningMessage") |> render() =~ "There aren&#39;t more attempts"
      refute view |> element("#guesses-board") |> render() =~ word
    end
  end

  describe "wordle ending" do
    test "when ends (no more attempts or win), the result button's displayed ", %{conn: conn} do
      ElixirWordle.MockWordsAPI
      |> expect(:get_todays_word, 2, fn -> {:ok, @word_info} end)

      assert {:ok, view, _html} = live(conn, "/")
      render_hook(view, :submit, %{guess: @word_info.word})

      assert view |> has_element?("#button-results")
    end
  end

end
