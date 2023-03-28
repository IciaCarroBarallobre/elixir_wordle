defmodule ElixirWordleWeb.WordleLive do
  use ElixirWordleWeb, :live_view
  import ElixirWordleWeb.ErrorComponents

  @max_attempts 6
  @wordle Application.compile_env(:elixir_wordle, :wordle_api, ElixirWordle.Wordle)

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(guesses: [], attempts: @max_attempts, message: nil)

    case @wordle.get_length_and_clue() do
      {:ok, %{length: length, clue: clue}} when length > 2 and length < 9 ->
        {:ok, socket |> assign(length: length, clue: clue)}

      _ ->
        {:ok,
         socket
         |> assign(
           length: 0,
           image_error: "Word not available",
           clue: "Today's word is not available",
           attempts: 0
         )}
    end
  end

  def handle_event("submit", %{"guess" => _guess}, %{assigns: %{attempts: 0}} = socket) do
    {:noreply, assign(socket, message: "There aren't more attempts")}
  end

  def handle_event("submit", %{"guess" => guess}, %{assigns: %{length: answer_length}} = socket)
      when answer_length < byte_size(guess) do
    {:noreply, assign(socket, message: "Too many letters")}
  end

  def handle_event("submit", %{"guess" => guess}, %{assigns: %{length: answer_length}} = socket)
      when answer_length > byte_size(guess) do
    {:noreply, assign(socket, message: "Not enough letters")}
  end

  def handle_event(
        "submit",
        %{"guess" => guess},
        %{assigns: %{attempts: attempts, guesses: guesses}} = socket
      ) do
    case @wordle.feedback(guess) do
      {:ok, %{guess: guess, feedback: feedback}} ->
        (Enum.all?(feedback, fn x -> x == :match end) &&
           {
             :noreply,
             socket
             |> assign(
               guesses: fill_guesses([{guess, feedback} | guesses], attempts - 1),
               attempts: 0,
               message: "You got it!"
             )
             |> push_event("new_attempt", %{attempts: false})
           }) ||
          {
            :noreply,
            socket
            |> assign(guesses: [{guess, feedback} | guesses], attempts: attempts - 1)
            |> push_event("new_attempt", %{attempts: true})
          }

      {:error, %{error: error_msg}} ->
        {:noreply, socket |> assign(message: %{error: error_msg})}
    end
  end

  def render(assigns) do
    ~H"""
    <button
      id="button-wordle-rules"
      phx-click={show_modal("wordle-rules")}
      class="mx-auto rounded-md right-0 top-2 sm:top-3 z-40 mt-2 sm:mt-1 fixed bg-slate-200 mr-4 sm:mr-8 border border-gray-200"
    >
      <Heroicons.question_mark_circle class=" h-5 w-5 md:w-8 md:h-8  text-gray-600" />
    </button>

    <%= modal_rules(assigns) %>

    <p class="bg-slate-100 rounded adjust-content mx-auto text-center w-fit px-2 mt-2 mb-6">
      Play a version of Wordle where <strong> all the words are related to Elixir</strong>.
    </p>

    <.live_component module={ElixirWordleWeb.PopupOfBoard} id="warningMessage" message={@message} />

    <%= if(@length == 0) do %>
      <div class="mx-auto space-y-1 max-w-xs w-4/5">
        <.image_error text={@image_error} />
      </div>
    <% else %>
      <div id="board" class=" grid grid-cols-1 gap-y-1">
        <.live_component
          module={ElixirWordleWeb.GuessesBoard}
          id="guesses"
          columns={@length}
          guesses={@guesses}
        />

        <.live_component
          module={ElixirWordleWeb.InputsBoard}
          id="inputs"
          attempts={@attempts}
          columns={@length}
        />
      </div>
    <% end %>

    <p class="adjust-content mx-auto text-center my-6">
      Clue: <strong><%= @clue %></strong>.
    </p>

    <.live_component
      module={ElixirWordleWeb.Keyboard}
      id="keyboard"
      word_max_length={@length}
      attempts={@attempts}
    />
    """
  end

  defp fill_guesses(guesses, 0) do
    guesses
  end

  defp fill_guesses([{guess, _feedback} | _t] = guesses, attempts) when attempts > 0 do
    word = for _i <- 1..String.length(guess), do: " ", into: ""
    fill_guesses([{word, nil} | guesses], attempts - 1)
  end

  def modal_rules(assigns) do
    ~H"""
    <.modal id="wordle-rules">
      <:title>
        <span class="text-center font-bold text-2xl  text-darkest_purple"> How to play </span>
      </:title>

      <div class="mt-2 text-sm leading-6 text-zinc-600">
        <span>
          In Elixir Wordle, players try to guess an Elixir-related word in a maximun of 6 tries.
        </span>
        <br /><br /> To start the game, enter any word: <br /><br />
        <.live_component
          module={ElixirWordleWeb.GuessesBoard}
          id="example-guesses"
          columns={6}
          guesses={[{"erlang", [:match, :letter_match, :letter_match, :fail, :fail, :fail]}]}
        />
        <br />
        <ul class=" rounded bg-slate-50">
          <li>
            <span class="font-bold"> A </span>, <span class="font-bold"> N </span>,
            <span class="font-bold"> G </span>
            aren't in the word at all.
          </li>
          <li>
            <span class="font-bold"> R </span>, <span class="font-bold"> L </span>
            is in the word but in the wrong tile.
          </li>
          <li><span class="font-bold"> E </span> is in the word and in the correct tile.</li>
        </ul>
        <br /> So, next try could be <span class="text-darkest_purple font-bold">ELIXIR</span>.
      </div>
    </.modal>
    """
  end
end
