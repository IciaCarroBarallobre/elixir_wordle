defmodule ElixirWordleWeb.WordleLiveTest do
  use ExUnit.Case
  use ElixirWordleWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import Mox

  setup :verify_on_exit!

  @generic_data %{
    answer: "erlang",
    clue: "A language",
    description: "Erlang is a general-purpose programming language and runtime environment.
          Erlang has built-in support for concurrency, distribution and fault tolerance."
  }

  @max_attempts 6

  describe "mount" do
    test "when the word cannot be obtained, this should be reflected in the view", %{conn: conn} do
      ElixirWordle.MockWordleAPI
      |> expect(:get_word_info, 2, fn -> {:error, "There is an error"} end)

      assert {:ok, view, html} = live(conn, "/")

      # When word is not available, set image error and warning at clue
      assert view |> element("#image_error") |> render() =~ "Word not available"
      assert view |> element("#clue") |> render() =~ "Today&#39;s word is not available"

      # When word is not available, board is not displayed
      refute html =~ "guesses-board"
      refute html =~ "inputs-board"
    end

    test "when the answer doesn't have a supported length (3..8), the word is considered unavailable in the view",
         %{conn: conn} do
      mock_data = %{answer: "ab", clue: "This is the clue", description: ""}

      ElixirWordle.MockWordleAPI
      |> expect(:get_word_info, 2, fn -> {:ok, mock_data} end)

      # When word is not available, set image error and warning at clue
      assert {:ok, view, html} = live(conn, "/")
      assert view |> element("#image_error") |> render() =~ "Word not available"

      clue_html = view |> element("#clue") |> render()
      assert clue_html =~ "Today&#39;s word is not available"

      # When word is not available, board is not displayed
      refute html =~ "guesses-board"
      refute html =~ "inputs-board"
    end

    test "when the answer has a supported length, both the input board and the clue are set",
         %{conn: conn} do
      ElixirWordle.MockWordleAPI |> expect(:get_word_info, 2, fn -> {:ok, @generic_data} end)

      assert {:ok, view, _html} = live(conn, "/")

      # Set the clue & the input board with maximum number attempts
      assert view |> element("#clue") |> render() =~ @generic_data.clue

      columns = String.length(@generic_data.answer)
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
      ElixirWordle.MockWordleAPI
      |> expect(:get_word_info, 2, fn -> {:ok, @generic_data} end)
      |> expect(:feedback, 1, fn guess, answer -> feedback_mock(guess, answer) end)

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
      ElixirWordle.MockWordleAPI
      |> expect(:get_word_info, 2, fn -> {:ok, @generic_data} end)

      assert {:ok, view, _html} = live(conn, "/")

      # Submit a guess which has less length than the answer, it has to display a warning message
      guess = "el"
      render_hook(view, :submit, %{guess: guess})
      refute view |> element("#guesses-board") |> render() =~ guess
      assert view |> element("#warningMessage") |> render() =~ "Not enough letters"
    end

    test "when the guess contains more letters than the answer, a message will be displayed",
         %{conn: conn} do
      ElixirWordle.MockWordleAPI
      |> expect(:get_word_info, 2, fn -> {:ok, @generic_data} end)

      assert {:ok, view, _html} = live(conn, "/")

      # Submit a guess which has more length than the answer, it has to display a warning message
      guess = "erlangss"
      render_hook(view, :submit, %{guess: guess})
      assert view |> element("#warningMessage") |> render() =~ "Too many letters"
      refute view |> element("#guesses-board") |> render() =~ guess
    end
  end

  describe "submit (when there aren't more attempts)" do
    test "when you accurately guess the word, then there's no more attempts", %{conn: conn} do
      ElixirWordle.MockWordleAPI
      |> expect(:get_word_info, 2, fn -> {:ok, @generic_data} end)
      |> expect(:feedback, 1, fn guess, answer -> feedback_mock(guess, answer) end)

      assert {:ok, view, _html} = live(conn, "/")
      render_hook(view, :submit, %{guess: @generic_data.answer})

      # The word is set at guesses-board & the congratulation message is displayed
      assert view |> element("#guesses-board") |> render() =~ @generic_data.answer
      assert view |> element("#warningMessage") |> render() =~ "You won !"

      # There are no more inputs' tiles
      refute view |> element("#inputs-board") |> render() =~ "input-1-1"

      # Attempting to submit another guess when there are no more attempts, it display a warning message
      word = "rtasmh"
      render_hook(view, :submit, %{guess: word})
      assert view |> element("#warningMessage") |> render() =~ "There aren&#39;t more attempts"
      refute view |> element("#guesses-board") |> render() =~ word
    end

    test "when you exhaust the max number of attempts, a message will be displayed", %{conn: conn} do
      ElixirWordle.MockWordleAPI
      |> expect(:get_word_info, 2, fn -> {:ok, @generic_data} end)
      |> expect(:feedback, @max_attempts, fn guess, answer -> feedback_mock(guess, answer) end)

      assert {:ok, view, _html} = live(conn, "/")

      # Exhaust attempts
      for _i <- 1..@max_attempts, do: render_hook(view, :submit, %{guess: "gnalre"})

      # Display the lost message
      assert view |> element("#warningMessage") |> render() =~ "You lost !"

      # There are no more inputs' tiles
      refute view |> element("#inputs-board") |> render() =~ "input-1-1"

      # Attempting to submit another guess when there are no more attempts, it display a warning message
      word = "irling"
      render_hook(view, :submit, %{guess: word})
      assert view |> element("#warningMessage") |> render() =~ "There aren&#39;t more attempts"
      refute view |> element("#guesses-board") |> render() =~ word
    end
  end

  describe "wordle ending" do
    test "when ends (no more attempts), it's  displayed the result button", %{conn: conn} do
      ElixirWordle.MockWordleAPI
      |> expect(:get_word_info, 2, fn -> {:ok, @generic_data} end)
      |> expect(:feedback, 1, fn guess, answer -> feedback_mock(guess, answer) end)

      assert {:ok, view, _html} = live(conn, "/")
      render_hook(view, :submit, %{guess: @generic_data.answer})

      assert view |> has_element?("#button-results")
    end
  end

  defp feedback_mock(guess, answer) do
    result = (guess == answer && :match) || :letter_match

    {:ok,
     %{
       guess: guess,
       feedback: for(_i <- 1..String.length(answer), do: result)
     }}
  end
end
