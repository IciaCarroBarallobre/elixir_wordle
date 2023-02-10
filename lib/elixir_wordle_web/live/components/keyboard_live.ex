defmodule ElixirWordleWeb.KeyboardLive do
  use ElixirWordleWeb, :live_component

  def render(assigns) do
    ~H"""
    <div
      class={
        " xl:w-2/3 " # width +1280px (ref: computer 1920)
        <> "md:w-4/5 " # width 726px - 1280px (ref: IPAD)
        <> " mx-auto w-full px-2 mb-5 " # width -726px (ref: phones)
        },
      aria-label="Keyboard"
    >

      <%= for {keyboard_line, span} <- [
          {["Q","W","E","R","T","Y","U","I","O","P"], 0},
          {["A","S","D","F","G","H","J","K", "L"], 0},
          {["delete","Z","X","C","V","B","N","M", "enter"], 1}
          ]
        do %>
        <!-- grid-cols-9 grid-cols-10 grid-cols-11 grid-cols-12 grid-cols-13 grid-cols-14 -->
        <div class={
            "mb-1"
            <>  " grid grid-cols-#{length(keyboard_line) + span} gap-1 grid-auto"
          }>
          <%= for key <- keyboard_line do %>
            <button
              class={
                "text-gray-800 font-semibold sm:text-lg uppercase text-center "
                <> "py-3 rounded bg-slate-200 hover:bg-slate-400 "
                <> "#{if key in ["enter"], do: "col-span-2"}"
                <> ""}
              type="button"
              data-key={key}
            >
              <%= case key do %>
                <% "delete" -> %>
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
