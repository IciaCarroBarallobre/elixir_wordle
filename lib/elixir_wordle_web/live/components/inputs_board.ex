defmodule ElixirWordleWeb.InputsBoard do
  use ElixirWordleWeb, :live_component

  @moduledoc """
    Inputs board, the remaining attempts they have left.
  """

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <div id={@id} class="mx-auto space-y-1 max-w-xs w-4/5">
      <%= for i <- 1..(@attempts), @attempts > 0 do %>
        <div class={"grid #{grid_cols_tailwind(@columns)} gap-1 "}>
          <%= for j <- 1..@columns do %>
            <div
              class={
                Enum.join(
                  [
                    "  justify-content ",
                    "text-gray-800 font-semibold text-xl uppercase text-center ",
                    " rounded p-2 ",
                    " border-2 border-slate-300  ",
                    " min-h-[3rem] "
                  ],
                  ""
                )
              }
              id={"input-#{i}-#{j}"}
            >
              <%= "\s" %>
            </div>
          <% end %>
        </div>
      <% end %>
    </div>
    """
  end

  def grid_cols_tailwind(number) do
    case number do
      3 -> "grid-cols-3"
      4 -> "grid-cols-4"
      5 -> "grid-cols-5"
      6 -> "grid-cols-6"
      7 -> "grid-cols-7"
      8 -> "grid-cols-8"
      9 -> "grid-cols-9"
    end
  end
end
