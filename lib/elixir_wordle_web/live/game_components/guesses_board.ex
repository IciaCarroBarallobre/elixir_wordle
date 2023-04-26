defmodule ElixirWordleWeb.GuessesBoard do
  use ElixirWordleWeb, :live_component

  @moduledoc """
    Screen Keyboard (linked to external keyboard)
  """

  attr(:id, :string, required: true)
  attr(:guesses, :list, required: true)
  attr(:columns, :integer, required: true)
  attr(:animation, :boolean, default: true)
  attr(:class, :string, default: "")

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <div id={@id} class={"mx-auto space-y-1 max-w-xs min-w-max w-full md:w-4/5 #{@class}"}>
      <%= for {word, feedback} <- Enum.reverse(@guesses) do %>
        <div
          class="grid gap-1"
          style={"grid-template-columns: repeat(#{@columns}, 1fr)"}
          data-row={"#{word}"}
        >
          <%= for {letter, letter_feedback, n} <- zip_letters_and_feedback(word, feedback) do %>
            <div class={
              "font-semibold text-xl uppercase text-center
               rounded p-2 border-2 min-h-[3rem]
               #{feedback_to_color(letter_feedback)}
               #{(!is_fake_feedback(letter_feedback) and @animation) && " animate-flip  animate-delay-#{n*150}"}"
            }>
              <%= [letter] %>
            </div>
          <% end %>
        </div>
      <% end %>
    </div>
    """
  end

  defp zip_letters_and_feedback(word, feedback),
    do:
      Enum.zip([
        String.to_charlist(word),
        feedback || fill_fake_feedback(word, feedback),
        0..String.length(word)
      ])

  defp feedback_to_color(feedback) do
    case feedback do
      :match -> "bg-purple border-dark_purple text-white "
      :letter_match -> "bg-lightest_purple border-light_purple text-gray-700 "
      :fail -> "bg-slate-100 border-slate-300 text-gray-800"
      _ -> "bg-slate-100"
    end
  end

  defp fill_fake_feedback(word, feedback) when is_nil(feedback),
    do: for(_i <- 1..String.length(word), do: :none)

  defp is_fake_feedback(feedback), do: :none == feedback
end
