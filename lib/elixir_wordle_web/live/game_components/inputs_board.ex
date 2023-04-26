defmodule ElixirWordleWeb.InputsBoard do
  use ElixirWordleWeb, :live_component

  @moduledoc """
    Inputs board, the remaining attempts they have left.
  """
  attr(:id, :string, required: true)
  attr(:attempts, :integer, required: true)
  attr(:columns, :integer, required: true)
  attr(:end?, :boolean)

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <div id={@id} class="mx-auto space-y-1 max-w-xs min-w-max w-full md:w-4/5">
      <%= for i <- 1..@attempts, @attempts > 0 do %>
        <div class="grid gap-1" style={"grid-template-columns: repeat(#{@columns}, 1fr)"}>
          <%= for j <- 1..@columns do %>
            <div
              id={"input-#{i}-#{j}"}
              class={"font-semibold text-xl uppercase text-center text-gray-800
               rounded p-2 border-2 min-h-[3rem] border-slate-300
               #{@end? && " bg-slate-50"}"
               }
            >
              <%= "\s" %>
            </div>
          <% end %>
        </div>
      <% end %>
    </div>
    """
  end
end
