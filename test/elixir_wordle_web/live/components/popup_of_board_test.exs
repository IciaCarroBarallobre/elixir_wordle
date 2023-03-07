defmodule ElixirWordleWeb.PopupOfBoardTest do
  use ExUnit.Case
  use ElixirWordleWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import LiveIsolatedComponent

  alias ElixirWordleWeb.PopupOfBoard

  describe "isolated popup behaviour" do
    test "If the message is nil, PopupOfBoard shouldn't show the popup" do
      {:ok, _view, html} = live_isolated_component(PopupOfBoard, assigns: %{message: nil})
      assert html =~ "hidden"
    end

    test "If the message is not nil, PopupOfBoard should show the popup" do
      {:ok, view, _html} = live_isolated_component(PopupOfBoard, assigns: %{message: nil})

      msg = "Example of msg"
      html = render(live_assign(view, :message, msg))

      refute html =~ "hidden"
      assert html =~ msg
    end
  end
end
