defmodule ElixirWordleWeb.PopupOfBoard do
  use ElixirWordleWeb, :live_component

  @moduledoc """
    Warnings about the game board.
  """

  attr(:id, :string, required: true)
  attr(:message, :string, default: nil)

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <div
      id={@id}
      class={
            "bg-darkest_purple text-white shadow-xl rounded
             adjust-content text-center self-center
             absolute right-0 left-0 z-10
             w-fit mx-auto p-4
             #{if(is_nil(@message), do: " hidden ", else: " block")}
             "
      }
    >
      <%= @message || "" %>
    </div>
    """
  end
end
