defmodule ElixirWordleWeb.WordleLiveTest do
  use ExUnit.Case
  use ElixirWordleWeb.ConnCase

  import Phoenix.LiveViewTest
  import Mox

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  describe "mount test" do
    test "connected mount", %{conn: conn} do
      ElixirWordle.MockWordleAPI
      |> expect(:get_length_and_clue, 2, fn -> {:ok, %{length: 5, clue: "This is the clue"}} end)

      assert {:ok, _view, html} = live(conn, "/")
      assert html =~ "Elixir Wordle"
    end

    test "answer has a non supported length", %{conn: conn} do
      mock_data = %{length: 2, clue: "This is the clue"}

      ElixirWordle.MockWordleAPI
      |> expect(:get_length_and_clue, 2, fn -> {:ok, mock_data} end)

      assert {:ok, _view, html} = live(conn, "/")
      assert html =~ "Word not available"
    end

    test "clue is always set", %{conn: conn} do
      mock_data = %{length: 6, clue: "This is the clue"}

      ElixirWordle.MockWordleAPI
      |> expect(:get_length_and_clue, 2, fn -> {:ok, mock_data} end)

      assert {:ok, _view, html} = live(conn, "/")
      assert html =~ mock_data.clue
    end
  end

  describe "when submit" do
    test "the guess has same length as answer", %{conn: conn} do
      mock_data = %{length: 6, clue: "This is the clue"}
      guess = for _i <- 1..mock_data.length, do: "a", into: ""

      ElixirWordle.MockWordleAPI
      |> expect(:get_length_and_clue, 2, fn -> {:ok, mock_data} end)

      ElixirWordle.MockWordleAPI
      |> expect(
        :feedback,
        1,
        fn guess ->
          {:ok, %{guess: guess, feedback: for(_i <- 1..String.length(guess), do: :letter_match)}}
        end
      )

      assert {:ok, view, _html} = live(conn, "/")
      assert render_hook(view, :submit, %{guess: guess}) =~ guess
    end

    test "the guess has less length than answer", %{conn: conn} do
      mock_data = %{length: 5, clue: "This is the clue"}
      guess = for _i <- 1..(mock_data.length - 1), do: "a", into: ""

      ElixirWordle.MockWordleAPI
      |> expect(:get_length_and_clue, 2, fn -> {:ok, mock_data} end)

      assert {:ok, view, _html} = live(conn, "/")
      assert render_hook(view, :submit, %{guess: guess}) =~ "Not enough letters"
    end

    test "the guess has more length than answer", %{conn: conn} do
      mock_data = %{length: 5, clue: "This is the clue"}
      guess = for _i <- 1..(mock_data.length + 1), do: "a", into: ""

      ElixirWordle.MockWordleAPI
      |> expect(:get_length_and_clue, 2, fn -> {:ok, mock_data} end)

      assert {:ok, view, _html} = live(conn, "/")
      assert render_hook(view, :submit, %{guess: guess}) =~ "Too many letters"
    end

    test "there aren't more attempts"
  end
end
