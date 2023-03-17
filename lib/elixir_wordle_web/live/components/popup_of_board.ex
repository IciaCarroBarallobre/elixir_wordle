defmodule ElixirWordleWeb.PopupOfBoard do
  use ElixirWordleWeb, :live_component

  @moduledoc """
    Warnings about the game board.
  """

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <div
      id={@id}
      class={
            "bg-darkest_purple text-white shadow-xl rounded
             adjust-content text-center
             fixed top-24 right-0 left-0 z-40
             w-fit mx-auto  py-2 px-4 animate-bounce
             #{if(is_nil(@message), do: " hidden ", else: " block")}
             "
      }
    >
      <%= @message || "" %>
    </div>
    """
  end
end
