defmodule ElixirWordleWeb.GuessesBoard do
  use ElixirWordleWeb, :live_component

  @moduledoc """
    Screen Keyboard (linked to external keyboard)
  """

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <div id={@id} class="mx-auto space-y-1 max-w-xs w-4/5">
      <%= for {word, feedback} <- Enum.reverse(@guesses) do %>
        <div class={"grid #{grid_cols_tailwind(@columns)} gap-1 "} data-row={"#{word}"}>
          <%= for {letter, result} <- Enum.zip(word |> String.to_charlist(), feedback) do %>
            <!-- bg-gray-200 bg-yellow-200 bg-green-200 -->
            <div class={
              Enum.join(
                [
                  "justify-content",
                  "font-semibold text-xl uppercase text-center ",
                  "rounded p-2 ",
                  " border-2 border-slate-300  ",
                  " min-h-[3rem] ",
                  wordle_result_to_color_tailwind(result)
                ],
                " "
              )
            }>
              <%= " #{to_string([letter])} " %>
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

  def wordle_result_to_color_tailwind(atom) do
    case atom do
      :match -> "bg-purple border-dark_purple text-white"
      :letter_match -> "bg-lightest_purple border-light_purple text-gray-700"
      :fail -> "bg-slate-100 text-gray-800"
      _ -> "bg-slate-50"
    end
  end
end
