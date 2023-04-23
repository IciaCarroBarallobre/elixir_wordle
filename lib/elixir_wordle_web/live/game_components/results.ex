defmodule ElixirWordleWeb.Results do
  use ElixirWordleWeb, :live_component
  alias Phoenix.LiveView.JS

  @moduledoc """
    Results of the game board.
  """

  def render(assigns) do
    ~H"""
    <div id={"#{@id}-div"}>
      <.modal id={"#{@id}"} show={@show}>
        <:title><%= (@win? && "Congrats! You won ✌️") || "Oh no, you lost 😖" %></:title>

        <div id="emoji-board" class="mx-auto text-center mt-8 mb-4 text-lg text-purple pb-2">
          <%= Phoenix.HTML.Format.text_to_html(
            "Elixir Wordle Day ##{Date.day_of_year(Date.utc_today())}\n" <>
              feedback_to_emoji(@feedback |> Enum.reverse())
          ) %>
        </div>

        <div class="text-center p-4 pb-8">
          <p class="text-lg text-purple pb-2">Answer is <b><%= String.upcase(@word) %></b></p>
          <div class="text-base leading-6 ">
            <p><b> Do you know that... </b> <%= @description %></p>
          </div>
        </div>

        <div class="flex flex-wrap justify-center items-center gap-x-8 md:gap-x-16 ">
          <div>
            <p class="text-lg">Next word</p>
            <p class="text-xl pl-4"><%= time_left_to_next_word(@current_time) %></p>
          </div>
          <div>
            <.button class="m-2" phx-click={JS.dispatch("elixir_wordle:clipcopy", to: "#emoji-board")}>
              Copy & share
            </.button>
          </div>
        </div>
      </.modal>
    </div>
    """
  end

  defp feedback_to_emoji(feedback) do
    for word_f <- feedback do
      for(letter_f <- word_f, do: letter_feedback_to_emoji(letter_f), into: "")
    end
    |> Enum.join("\n")
  end

  defp letter_feedback_to_emoji(:match), do: "⬛"
  defp letter_feedback_to_emoji(:letter_match), do: "🟪"
  defp letter_feedback_to_emoji(_), do: "⬜"

  defp time_left_to_next_word(current_time) do
    n = %{current_time | day: current_time.day + 1, hour: 0, minute: 0, second: 0}
    Time.from_seconds_after_midnight(DateTime.diff(n, current_time))
  end
end
