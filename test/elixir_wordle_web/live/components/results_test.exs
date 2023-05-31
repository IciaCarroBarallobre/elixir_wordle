defmodule ElixirWordleWeb.ResultsTest do
  use ExUnit.Case
  use ElixirWordleWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import LiveIsolatedComponent

  alias ElixirWordleWeb.Results

  describe "isolated Results behaviour" do
    test "Giving a current time (DateTime), the clock is set as next day countdown" do
      {:ok, view, _html} =
        live_isolated_component(
          Results,
          assigns: %{
            id: "result",
            word: "Example",
            description: "This is an example?",
            win?: true,
            current_time: DateTime.from_naive!(~N[2023-05-23 10:00:00], "Etc/UTC")
          }
        )

      assert view |> element("#next-word-clock") |> render() =~ "14:00:00"
    end
  end
end
