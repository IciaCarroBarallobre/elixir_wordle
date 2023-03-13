defmodule ElixirWordleWeb.Keyboard do
  use ElixirWordleWeb, :live_component

  @moduledoc """
    Screen Keyboard (linked to external keyboard)
  """

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <div
      class={
        Enum.join(
          [
            " xl:w-2/3 ",
            "md:w-4/5 ",
            " mx-auto w-full px-2 mb-5 "
          ],
          " "
        )
      }
      aria-label="Keyboard"
      x-data="{
        keyValue: '',
        lengthValue: 0,
        changeKey(value, length) {
          $dispatch('key-press', {key: value, length: length})
        },
        keyboardPressUp(value) {
          $refs['key-'+value].focus()
          $refs['key-'+value].click()
        },
      }"
      id={@id}
      phx-hook="KeyboardPress"
    >
      <%= for {keyboard_line, span} <- [
          {["Q","W","E","R","T","Y","U","I","O","P"], 0},
          {["A","S","D","F","G","H","J","K", "L"], 0},
          {["Enter","Z","X","C","V","B","N","M", "Backspace"], 1}
          ]
        do %>
        <!-- grid-cols-9 grid-cols-10 -->
        <div class={
          Enum.join(
            [
              "mb-1",
              "grid grid-cols-#{length(keyboard_line) + span} gap-1 grid-auto"
            ],
            " "
          )
        }>
          <%= for key <- keyboard_line do %>
            <button
              class={
                Enum.join(
                  [
                    " text-gray-800 font-semibold sm:text-lg uppercase text-center ",
                    "py-3 rounded bg-slate-200 hover:bg-slate-400 active:bg-slate-300 focus:ring focus:outline-none ",
                    "#{if key in ["Enter"], do: "col-span-2"}"
                  ],
                  " "
                )
              }
              id={"keyboard-#{key}"}
              type="button"
              data-key={key}
              x-ref={"key-#{key}"}
              @click={"changeKey('#{key}', #{@word_max_length})"}
              {%{"@keyup.window.#{key}"=> "keyboardPressUp('#{key}')"}}
            >
              <%= case key do %>
                <% "Backspace" -> %>
                  <Heroicons.backspace class="mx-auto w-6 h-6" />
                <% _ -> %>
                  <%= key %>
              <% end %>
            </button>
          <% end %>
        </div>
      <% end %>
    </div>
    """
  end
end
