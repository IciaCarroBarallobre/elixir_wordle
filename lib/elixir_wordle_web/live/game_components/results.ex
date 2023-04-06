defmodule ElixirWordleWeb.Results do
  use ElixirWordleWeb, :live_component

  @moduledoc """
    Warnings about the game board.
  """

  def render(assigns) do
    ~H"""
    <div id={"#{@id}-div"}>
      <.modal id={@id} show={@show}>
        <:title>
          <span class="text-center font-bold text-2xl  text-dark_purple">
            Answer: <%= String.upcase(@word) %>
          </span>
        </:title>
        <:subtitle>
          <span class="font-semibold text-xl text-purple">
            <%= (@win? && "Congrats! You won ✌️") || "Oh no, you lost 😖" %>
          </span>
        </:subtitle>
        <div class="mx-auto text-center my-8">
          <%= for word_feedback <- @feedback |> Enum.reverse() do %>
            <%= for letter_feedback <- word_feedback,
                    do: feedback_to_colors(letter_feedback),
                    into: "" %>
            <br />
          <% end %>
        </div>

        <div class="px-4 mx-4 p-2 mt-2 text-base leading-6 text-zinc-600 rounded-md bg-slate-50 m-4 ">
          <p>
            <%= @description %>
          </p>
        </div>
      </.modal>
    </div>
    """
  end

  defp feedback_to_colors(value) do
    case value do
      :match -> "⬛"
      :letter_match -> "🟪"
      _ -> "⬜"
    end
  end
end
