defmodule ElixirWordleWeb.InputsBoard do
  use ElixirWordleWeb, :live_component

  @moduledoc """
    Inputs board, the remaining attempts they have left.
  """

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <div id="inputs" class={"mx-auto grid grid-cols-#{@word_max_length} gap-1 max-w-xs w-4/5"}>
      <%= for i <- 1..(@attempts), @attempts > 0 do %>
        <%= for j <- 1..@word_max_length do %>
          <!-- bg-gray-200 bg-yellow-200 bg-green-200 -->
          <div
            class={
          "  justify-content "
          <> "text-gray-800 font-semibold text-xl uppercase text-center "
          <> " rounded p-2 "
          <> " border-2 border-slate-300  "
          <> " min-h-[3rem]"
          }
            id={"input-#{i}-#{j}"}
          >
            <%= "\s" %>
          </div>
        <% end %>
      <% end %>
    </div>
    """
  end
end
