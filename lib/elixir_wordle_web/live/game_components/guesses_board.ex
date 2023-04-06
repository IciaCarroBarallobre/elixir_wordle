defmodule ElixirWordleWeb.GuessesBoard do
  use ElixirWordleWeb, :live_component

  @moduledoc """
    Screen Keyboard (linked to external keyboard)
  """
  @default_color_system %{
    match: "bg-purple border-dark_purple text-white ",
    letter_match: "bg-lightest_purple border-light_purple text-gray-700 ",
    fail: "bg-slate-100 text-gray-800 "
  }

  attr :animation, :boolean, default: true

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <div id={@id} class="mx-auto space-y-1 max-w-xs w-4/5">
      <%= for {word, feedback} <- Enum.reverse(@guesses) do %>
        <div class={"grid #{grid_cols_tailwind(@columns)} gap-1 "} data-row={"#{word}"}>
          <%= for {letter, result, number} <- Enum.zip(
            [
              word |> String.to_charlist(),
              (feedback || fill_feedback(word, feedback)),
              0..(@columns-1)
            ]
          ) do %>
            <div class={
              " justify-content
                font-semibold text-xl uppercase text-center
                rounded p-2 border-2 min-h-[3rem]
                #{(not is_filler_feedback(feedback) and @animation) && " animate-flip animate-delay-#{number*150}"}
                #{wordle_result_to_color_tailwind(result)}

                "
            }>
              <!--- animate-delay-150 animate-delay-300 animate-delay-450 animate-delay-600
            animate-delay-750 animate-delay-900 animate-delay-1050 animate-delay-1200 -->
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
      _ -> ""
    end
  end

  defp wordle_result_to_color_tailwind(atom, color_system \\ @default_color_system),
    do: color_system |> Map.get(atom, "bg-slate-100")

  defp fill_feedback(word, feedback) when is_nil(feedback),
    do: for(_i <- 1..String.length(word), do: :none)

  defp is_filler_feedback(feedback), do: is_nil(feedback)
end
