defmodule ElixirWordleWeb.WordleLiveTest do
  use ExUnit.Case
  use ElixirWordleWeb.ConnCase

  import Phoenix.LiveViewTest
  import Mox

  setup :verify_on_exit!

  describe "directly testable scenarios derived from mount" do
    test "when the word cannot be obtained, this should be reflected in the view", %{conn: conn} do
      ElixirWordle.MockWordleAPI
      |> expect(:get_length_and_clue, 2, fn -> {:error, "There is an error"} end)

      assert {:ok, _view, html} = live(conn, "/")

      # Board image
      assert html =~ "Word not available"

      # Clue
      assert html =~ "Today&#39;s word is not available"
    end

    test "when the answer doesn't have a supported length, the word is considered unavailable in the view",
         %{conn: conn} do
      mock_data = %{length: 2, clue: "This is the clue"}

      ElixirWordle.MockWordleAPI
      |> expect(:get_length_and_clue, 2, fn -> {:ok, mock_data} end)

      assert {:ok, _view, html} = live(conn, "/")

      # Board image
      assert html =~ "Word not available"

      # Clue
      assert html =~ "Today&#39;s word is not available"
      refute html =~ mock_data.clue
    end

    test "when the answer has a supported length, both the input board and the clue are set", %{
      conn: conn
    } do
      mock_data = %{length: 6, clue: "This is the clue"}

      ElixirWordle.MockWordleAPI
      |> expect(:get_length_and_clue, 2, fn -> {:ok, mock_data} end)

      assert {:ok, _view, html} = live(conn, "/")

      # Board image, 6 attempts
      assert html =~ "input-1-1"
      assert html =~ "input-6-1"

      # Clue
      assert html =~ mock_data.clue
    end
  end

  describe "directly testable scenarios derived from when the guess is submitted and there are more attempts" do
    test "when the guess is not the answer but has the same length, the guess will be displayed in the view",
         %{conn: conn} do
      mock_data = %{length: 6, clue: "This is the clue"}
      guess = "abcdef"

      ElixirWordle.MockWordleAPI
      |> expect(:get_length_and_clue, 2, fn -> {:ok, mock_data} end)

      # The word is not guessed
      ElixirWordle.MockWordleAPI
      |> expect(:feedback, 1, fn guess ->
        {:ok, %{guess: guess, feedback: for(_i <- 1..String.length(guess), do: :letter_match)}}
      end)

      assert {:ok, view, _html} = live(conn, "/")
      assert render_hook(view, :submit, %{guess: guess}) =~ guess
    end

    test "when the guess has less length than the answer, a message will be displayed", %{
      conn: conn
    } do
      mock_data = %{length: 6, clue: "This is the clue"}
      guess = "abcd"

      ElixirWordle.MockWordleAPI
      |> expect(:get_length_and_clue, 2, fn -> {:ok, mock_data} end)

      assert {:ok, view, _html} = live(conn, "/")
      assert render_hook(view, :submit, %{guess: guess}) =~ "Not enough letters"
    end

    test "when the guess contains more letters than the answer, a message will be displayed", %{
      conn: conn
    } do
      mock_data = %{length: 6, clue: "This is the clue"}
      guess = "abcdefg"

      ElixirWordle.MockWordleAPI
      |> expect(:get_length_and_clue, 2, fn -> {:ok, mock_data} end)

      assert {:ok, view, _html} = live(conn, "/")
      assert render_hook(view, :submit, %{guess: guess}) =~ "Too many letters"
    end
  end

  describe "directly testable scenarios derived from when there aren't more attempts" do
    test "when you accurately guess the word, there's no more attempts", %{conn: conn} do
      mock_data = %{length: 6, clue: "This is the clue"}
      guess = "abcdef"

      ElixirWordle.MockWordleAPI
      |> expect(:get_length_and_clue, 2, fn -> {:ok, mock_data} end)

      # The word is guessed
      ElixirWordle.MockWordleAPI
      |> expect(:feedback, 1, fn guess ->
        {:ok, %{guess: guess, feedback: for(_i <- 1..String.length(guess), do: :match)}}
      end)

      assert {:ok, view, _html} = live(conn, "/")
      html = render_hook(view, :submit, %{guess: guess})

      # The word set at page & the congratulation message
      assert html =~ guess
      assert html =~ "You got it!"

      # No tiles to input
      refute html =~ "input-1-1"

      # Attempting to submit another guess when there are no more attempts available
      other_guess = "ghijkl"
      html = view |> render_hook(:submit, %{guess: other_guess})
      assert html =~ "There aren&#39;t more attempts"
      refute html =~ other_guess
    end

    test "when you exhaust the max number of attempts, a message will be displayed", %{conn: conn} do
      max_attempts = 6
      mock_data = %{length: 6, clue: "This is the clue"}
      guess = "abcdef"

      ElixirWordle.MockWordleAPI
      |> expect(:get_length_and_clue, 2, fn -> {:ok, mock_data} end)

      # The word is not guessed
      ElixirWordle.MockWordleAPI
      |> expect(:feedback, max_attempts, fn guess ->
        {:ok, %{guess: guess, feedback: for(_i <- 1..String.length(guess), do: :letter_match)}}
      end)

      assert {:ok, view, _html} = live(conn, "/")

      for _i <- 1..max_attempts do
        render_hook(view, :submit, %{guess: guess})
      end

      # Attempting to submit another guess when there are no more attempts available
      other_guess = "ghijkl"
      html = view |> render_hook(:submit, %{guess: other_guess})
      assert html =~ "There aren&#39;t more attempts"
      refute html =~ other_guess
    end
  end
end
