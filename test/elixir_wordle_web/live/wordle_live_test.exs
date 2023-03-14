defmodule ElixirWordleWeb.WordleLiveTest do
  import Phoenix.LiveViewTest
  use ElixirWordleWeb.ConnCase
  use ExUnit.Case

  # Import Mox && setup fixtures
  import Mox

  setup [:set_mox_private, :verify_on_exit!]

  describe "baseline" do
    test "connected mount", %{conn: conn} do
      assert {:ok, _view, html} = live(conn, "/")
      assert html =~ "Elixir Wordle"
    end

    test "handled event", %{conn: conn} do
      assert {:ok, view, _html} = live(conn, "/")
      assert render_hook(view, :submit, %{guess: "state"}) =~ "state"
    end
  end

  describe "Popup of Board: error msg when submit" do
    test "Not enough letters", %{conn: conn} do
      answer_len = 5
      guess = for _i <- 1..(answer_len - 1), do: "a", into: ""

      Mox.stub(
        ElixirWordle.Wordle,
        :get_length_and_clue,
        fn -> {:ok, %{length: answer_len, clue: ""}} end
      )

      assert {:ok, view, _html} = live(conn, "/")

      assert render_hook(view, :submit, %{guess: guess}) =~ "Not enough letters"
    end

    test "Too many letter", %{conn: conn} do
      answer_len = 5
      guess = for _i <- 1..(answer_len + 1), do: "a", into: ""

      Mox.stub(
        ElixirWordle.Wordle,
        :get_length_and_clue,
        fn -> {:ok, %{length: answer_len, clue: ""}} end
      )

      assert {:ok, view, _html} = live(conn, "/")

      assert render_hook(view, :submit, %{guess: guess}) =~ "Too many letters"
    end
  end
end
