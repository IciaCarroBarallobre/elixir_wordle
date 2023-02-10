defmodule ElixirWordleWeb.WordleLive do
  use ElixirWordleWeb, :live_view

  def mount(_params, _session, socket) do
    answer = %{
      word: "sigil",
      clue: "Mechanisms for working with textual representations",
      description:
        " Sigils start with the tilde (~) character which is followed by a letter (which identifies the sigil) and then a delimiter."
    }

    guesses = [
      {"atoms", [:fail, :fail, :fail, :fail, :letter_match]},
      {"chars", [:fail, :fail, :fail, :fail, :letter_match]},
      {"aaaaa", [:fail, :match, :fail, :match, :match]},
      {"regex", [:fail, :fail, :match, :fail, :fail]},
      {"signs", [:match, :match, :match, :fail, :fail]},
      {"sigil", [:match, :match, :match, :match, :match, :match]}
    ]

    {:ok, socket |> assign(answer: answer, guesses: guesses, toggle: "off")}
  end

  def handle_event("toggle-change", %{"toggle" => toggle}, socket) do
    toggle = if toggle == "1", do: "on", else: "off"

    {:noreply, assign(socket, :toggle, toggle)}
  end

  def handle_event("key-press", %{"key" => value}, socket) do
    # value = if value == "1", do: "on", else: "off"
    IO.inspect(value)
    # {:noreply, assign(socket, :toggle, toggle)}
    {:noreply, assign(socket, :value, value)}
  end

  def render(assigns) do
    ~H"""
    <p class="bg-slate-100 rounded adjust-content mx-auto text-center w-fit px-2 mt-2 mb-6">
      Play a version of Wordle where <strong> all the words are related to Elixir</strong>.
    </p>
    <div
      class="flex items-center justify-start"
      x-data="{ toggle: '0' }"
      x-init="() => { $watch('toggle', active => $dispatch('toggle-change', { toggle: active })) }"
      @keydown.window.slash="toggle === '0' ? toggle = '1' : toggle = '0'"
      id="toggle-example"
      phx-hook="Toggle"
    >
      <div
        class="relative w-12 h-6 rounded-full transition duration-200 ease-linear"
        x-bind:class="[toggle === '1' ? 'bg-green-400' : 'bg-gray-400']"
      >
        <label
          for="toggle"
          class="absolute left-0 w-6 h-6 mb-2 bg-white border-2 rounded-full cursor-pointer transition transform duration-100 ease-linear"
          x-bind:class="[toggle === '1' ? 'translate-x-full border-green-400' : 'translate-x-0 border-gray-400']"
        >
        </label>
        <input type="hidden" name="toggle" value="off" />
        <input
          type="checkbox"
          id="toggle"
          name="toggle"
          class="hidden"
          @click="toggle === '0' ? toggle = '1' : toggle = '0'"
        />
      </div>
      <%= @toggle %>
    </div>
    <!-- grid-cols-4 grid-cols-5 grid-cols-6 grid-cols-7 grid-cols-8 -->
    <div class={
      "mx-auto grid grid-cols-#{String.length(@answer.word)} gap-1 max-w-xs w-4/5 "
    }>
      <%= for {word, feedback} <- @guesses do %>
        <%= for {letter, result} <- Enum.zip(word |> String.to_charlist(), feedback) do %>
          <!-- bg-gray-200 bg-yellow-200 bg-green-200 -->
          <div class={
            "  justify-content "
            <> "text-gray-800 font-semibold text-xl uppercase text-center "
            <> "rounded p-2 "
            <> wordle_result_to_color_tailwind(result)
            <> " border-2 border-slate-300  "
          }>
            <%= " #{to_string([letter])} " %>
          </div>
        <% end %>
      <% end %>
    </div>

    <p class="adjust-content mx-auto text-center my-6">
      Clue: <strong><%= @answer.clue %></strong>.
    </p>

    <.live_component module={ElixirWordleWeb.KeyboardLive} id="keyboard" />
    """
  end

  def wordle_result_to_color_tailwind(atom) do
    case atom do
      :match -> "bg-elixir_300 border-elixir "
      :letter_match -> "bg-elixir_100 border-elixir_700"
      :fail -> "bg-slate-100"
      _ -> "bg-slate-50"
    end
  end
end
