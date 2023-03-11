defmodule ElixirWordleWeb.GuessesBoard do
  use ElixirWordleWeb, :live_component

  @moduledoc """
    Screen Keyboard (linked to external keyboard)
  """

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <div id="inputs_grid" class="mx-auto space-y-1 max-w-xs w-4/5">
      <!-- grid-cols-4 grid-cols-5 grid-cols-6 grid-cols-7 grid-cols-8 -->
      <%= for {word, feedback} <- Enum.reverse(@guesses) do %>
        <div class={"grid grid-cols-#{@word_max_length} gap-1"} data-row={"#{word}"}>
          <%= for {letter, result} <- Enum.zip(word |> String.to_charlist(), feedback) do %>
            <!-- bg-gray-200 bg-yellow-200 bg-green-200 -->
            <div class={
            "  justify-content "
            <> "text-gray-800 font-semibold text-xl uppercase text-center "
            <> "rounded p-2 "
            <> wordle_result_to_color_tailwind(result)
            <> " border-2 border-slate-300  "
            <> " min-h-[3rem]"
          }>
              <%= " #{to_string([letter])} " %>
            </div>
          <% end %>
        </div>
      <% end %>
    </div>
    """
  end

  def wordle_result_to_color_tailwind(atom) do
    case atom do
      :match -> "bg-purple border-dark_purple "
      :letter_match -> "bg-lightest_purple border-light_purple"
      :fail -> "bg-slate-100"
      _ -> "bg-slate-50"
    end
  end
end
