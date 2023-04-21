defmodule ElixirWordleWeb.Results do
  use ElixirWordleWeb, :live_component

  @moduledoc """
    Results of the game board.
  """

  def render(assigns) do
    ~H"""
    <div id={"#{@id}-div"}>
      <.modal id={"#{@id}"} show={@show}>
        <:title><%= (@win? && "Congrats! You won ✌️") || "Oh no, you lost 😖" %></:title>

        <div class="mx-auto text-center my-8">
          <%= for word_feedback <- @feedback |> Enum.reverse() do %>
            <%= for letter_feedback <- word_feedback,
                    do: feedback_to_emoji(letter_feedback),
                    into: "" %>
            <br />
          <% end %>
        </div>

        <p class="text-center text-lg text-purple">
          Answer is <b><%= String.upcase(@word) %></b>
        </p>

        <div class="text-zinc-600 ">
          <div class="px-4 mx-4 p-2 mt-2 text-base leading-6 m-4 ">
            <p><b> Do you know that... </b> <%= @description %></p>
          </div>
          <div class=" shadow-lg text-lg m-4 px-6 py-2  leading-6 text-center mx-auto rounded-md bg-light_purple w-fit text-white ">
            <p>Next word in</p>
            <p class="text-xl"><%= time_left_to_next_word(@current_time) %></p>
          </div>
        </div>
      </.modal>
    </div>
    """
  end

  defp feedback_to_emoji(:match), do: "⬛"
  defp feedback_to_emoji(:letter_match), do: "🟪"
  defp feedback_to_emoji(_), do: "⬜"

  defp time_left_to_next_word(current_time) do
    n = %{current_time | day: current_time.day + 1, hour: 0, minute: 0, second: 0}
    Time.from_seconds_after_midnight(DateTime.diff(n, current_time))
  end
end
