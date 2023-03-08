defmodule ElixirWordleWeb.WordleLiveTest do
  import Phoenix.LiveViewTest
  use ExUnit.Case
  use ElixirWordleWeb.ConnCase

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

  describe "Popup of Board: error msg when submit (keyboard)" do
    test "Too many letters"

    test "Not enough letter", %{conn: conn} do
      assert {:ok, view, _html} = live(conn, "/")
      assert render_hook(view, :submit, %{guess: "four"}) =~ "Not enough letter"
    end

    test "Delete msg if key-press"
  end

  describe "Guesses & Inputs" do
    test "Consistent number of attempts: with 0 guesses, we have the maximum number of entries left."
    test "Consistent number of attempts: With maximum number of guesses, we have 0 entries left."
    test "Consistent number of attempts: with n guesses .. inputs = attempts - n guesses"
  end
end
