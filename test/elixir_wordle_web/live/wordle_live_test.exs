defmodule ElixirWordleWeb.WordleLiveTest do
  use ExUnit.Case
  use ElixirWordleWeb.ConnCase

  import Phoenix.LiveViewTest
  import Mox

  setup :verify_on_exit!

  describe "directly testable scenarios derived from mount" do
    test "when the word cannot be obtained, this should be reflected in the view", %{conn: conn} do
      ElixirWordle.MockWordleAPI
      |> expect(:get_word_info, 2, fn -> {:error, "There is an error"} end)

      assert {:ok, view, html} = live(conn, "/")

      # Image error msg
      assert view |> element("#image_error") |> render() =~ "Word not available"

      # Input Board & Guesses board is no setted
      html =~ "guesses-board"
      html =~ "inputs-board"

      # Clue behaviour
      clue_html = view |> element("#clue") |> render()
      assert clue_html =~ "Today&#39;s word is not available"
    end

    test "when the answer doesn't have a supported length, the word is considered unavailable in the view",
         %{conn: conn} do
      mock_data = %{answer: "ab", clue: "This is the clue", description: ""}

      ElixirWordle.MockWordleAPI
      |> expect(:get_word_info, 2, fn -> {:ok, mock_data} end)

      assert {:ok, view, html} = live(conn, "/")

      # Image error msg
      assert view |> element("#image_error") |> render() =~ "Word not available"

      # Input Board & Guesses board is no setted
      html =~ "guesses-board"
      html =~ "inputs-board"

      # Clue behaviour
      clue_html = view |> element("#clue") |> render()
      assert clue_html =~ "Today&#39;s word is not available"
      refute clue_html =~ mock_data.clue
    end

    test "when the answer has a supported length, both the input board and the clue are set", %{
      conn: conn
    } do
      mock_data = %{answer: "abcdef", clue: "This is the clue", description: ""}
      columns = String.length(mock_data.answer)

      ElixirWordle.MockWordleAPI
      |> expect(:get_word_info, 2, fn -> {:ok, mock_data} end)

      assert {:ok, view, _html} = live(conn, "/")

      # Board image, 6 attempts
      input_board_html = view |> element("#inputs-board") |> render()

      assert String.contains?(input_board_html, [
               "input-1-1",
               "input-1-#{columns}",
               "input-6-1",
               "input-6-#{columns}"
             ])

      # Clue
      assert view |> element("#clue") |> render() =~ mock_data.clue
    end
  end

  describe "directly testable scenarios derived from when the guess is submitted and there are more attempts" do
    test "when the guess is not the answer but has the same length, the guess will be displayed in the view",
         %{conn: conn} do
      mock_data = %{answer: "elixirw", clue: "This is the clue", description: ""}
      guess = "elixirr"

      ElixirWordle.MockWordleAPI
      |> expect(:get_word_info, 2, fn -> {:ok, mock_data} end)

      ElixirWordle.MockWordleAPI
      |> expect(:feedback, 1, fn guess, answer -> ElixirWordle.Wordle.feedback(guess, answer) end)

      assert {:ok, view, _html} = live(conn, "/")

      # Submit a supported length guess, has to be displayed on the guesses board
      render_hook(view, :submit, %{guess: guess})
      assert view |> element("#guesses-board") |> render() =~ guess

      # Now, there are 5 inputs attempts left
      assert view |> element("#inputs-board") |> render() =~ "input-5-"
      refute view |> element("#inputs-board") |> render() =~ "input-6-"
    end

    test "when the guess has less length than the answer, a message will be displayed", %{
      conn: conn
    } do
      mock_data = %{answer: "elixirw", clue: "This is the clue", description: ""}
      guess = "el"

      ElixirWordle.MockWordleAPI
      |> expect(:get_word_info, 2, fn -> {:ok, mock_data} end)

      assert {:ok, view, _html} = live(conn, "/")

      # Submit guess, which has less length than the answer, display a message
      render_hook(view, :submit, %{guess: guess})
      assert view |> element("#warningMessage") |> render() =~ "Not enough letters"
      refute view |> element("#guesses-board") |> render() =~ guess
    end

    test "when the guess contains more letters than the answer, a message will be displayed", %{
      conn: conn
    } do
      mock_data = %{answer: "elixirw", clue: "This is the clue", description: ""}
      guess = "elixirwww"

      ElixirWordle.MockWordleAPI
      |> expect(:get_word_info, 2, fn -> {:ok, mock_data} end)

      assert {:ok, view, _html} = live(conn, "/")

      # Submit guess, which has less length than the answer, display a message
      render_hook(view, :submit, %{guess: guess})
      assert view |> element("#warningMessage") |> render() =~ "Too many letters"
      refute view |> element("#guesses-board") |> render() =~ guess
    end
  end

  describe "directly testable scenarios derived from when there aren't more attempts" do
    test "when you accurately guess the word, there's no more attempts", %{conn: conn} do
      mock_data = %{answer: "elixirw", clue: "This is the clue", description: ""}

      ElixirWordle.MockWordleAPI
      |> expect(:get_word_info, 2, fn -> {:ok, mock_data} end)

      ElixirWordle.MockWordleAPI
      |> expect(:feedback, 1, fn guess, answer -> ElixirWordle.Wordle.feedback(guess, answer) end)

      assert {:ok, view, _html} = live(conn, "/")

      render_hook(view, :submit, %{guess: mock_data.answer})

      # The word set at page & the congratulation message
      assert view |> element("#guesses-board") |> render() =~ mock_data.answer
      assert view |> element("#warningMessage") |> render() =~ "You won !"

      # No inputs' tiles
      refute view |> element("#inputs-board") |> render() =~ "input-1-1"

      # Attempting to submit another guess when there are no more attempts available
      no_more_attempts_guess = "abcdefg"
      render_hook(view, :submit, %{guess: no_more_attempts_guess})
      assert view |> element("#warningMessage") |> render() =~ "There aren&#39;t more attempts"
      refute view |> element("#guesses-board") |> render() =~ no_more_attempts_guess
    end

    test "when you exhaust the max number of attempts, a message will be displayed", %{conn: conn} do
      max_attempts = 6

      mock_data = %{answer: "example", clue: "This is the clue", description: "blah blah"}
      guess = "abcdefg"

      ElixirWordle.MockWordleAPI
      |> expect(:get_word_info, 2, fn -> {:ok, mock_data} end)

      ElixirWordle.MockWordleAPI
      |> expect(:feedback, max_attempts, fn guess, answer ->
        ElixirWordle.Wordle.feedback(guess, answer)
      end)

      assert {:ok, view, _html} = live(conn, "/")

      # catch the last attempt
      for _i <- 1..max_attempts, do: render_hook(view, :submit, %{guess: guess})

      # exhaust attempts & the lost message
      assert view |> element("#warningMessage") |> render() =~ "You lost !"
      refute view |> element("#guesses-board") |> render() =~ mock_data.answer

      # No inputs' tiles
      refute view |> element("#inputs-board") |> render() =~ "input-1-1"

      # Attempting to submit another guess when there are no more attempts available
      other_guess = "gfedcba"
      render_hook(view, :submit, %{guess: other_guess})
      assert view |> element("#warningMessage") |> render() =~ "There aren&#39;t more attempts"
      refute view |> element("#guesses-board") |> render() =~ other_guess
    end
  end
end
