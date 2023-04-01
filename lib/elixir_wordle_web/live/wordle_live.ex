defmodule ElixirWordleWeb.WordleLive do
  use ElixirWordleWeb, :live_view
  import ElixirWordleWeb.ErrorComponents

  @max_attempts 6
  @wordle Application.compile_env(:elixir_wordle, :wordle_api, ElixirWordle.Wordle)

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(guesses: [], attempts: @max_attempts, message: nil, win?: false)

    case @wordle.get_word_info() do
      {:ok, %{answer: answer, clue: clue, description: description}}
      when byte_size(answer) > 2 and byte_size(answer) < 9 ->
        {:ok,
         socket
         |> assign(
           answer: answer,
           length: String.length(answer),
           clue: clue,
           description: description
         )}

      _ ->
        {:ok,
         socket
         |> assign(
           length: 0,
           image_error_msg: "Word not available",
           clue: "Today's word is not available",
           attempts: 0
         )
         |> push_event("new_attempt", %{attempts: false})}
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
        %{assigns: %{attempts: attempts, guesses: guesses, answer: answer}} = socket
      ) do
    with {:ok, %{guess: guess, feedback: feedback}} <- @wordle.feedback(guess, answer),
         win? <- Enum.all?(feedback, fn x -> x == :match end),
         lost? <- Enum.any?(feedback, fn x -> x != :match end) and attempts == 1 do
      if win? or lost? do
        {
          :noreply,
          socket
          |> assign(
            guesses: fill_guesses([{guess, feedback} | guesses], attempts - 1),
            attempts: 0,
            message: "You #{(win? && "won") || "lost"} !",
            win?: win?
          )
          |> push_event("new_attempt", %{attempts: false})
        }
      else
        {
          :noreply,
          socket
          |> assign(guesses: [{guess, feedback} | guesses], attempts: attempts - 1)
          |> push_event("new_attempt", %{attempts: true})
        }
      end
    else
      {:error, %{error: error_msg}} ->
        {:noreply, socket |> assign(message: %{error: error_msg})}

      _ ->
        {:noreply, socket |> assign(message: %{error: "Error"})}
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

    <.live_component module={ElixirWordleWeb.Rules} id="wordle-rules" />

    <p class="bg-slate-100 rounded adjust-content mx-auto text-center w-fit px-2 mt-2 mb-6">
      Play a version of Wordle where <strong> all the words are related to Elixir</strong>.
    </p>

    <.live_component module={ElixirWordleWeb.PopupOfBoard} id="warningMessage" message={@message} />

    <%= if(@length == 0) do %>
      <div class="mx-auto space-y-1 max-w-xs w-4/5">
        <.image_error text={@image_error_msg} id="image_error" />
      </div>
    <% else %>
      <div id="board" class=" grid grid-cols-1 gap-y-1">
        <.live_component
          module={ElixirWordleWeb.GuessesBoard}
          id="guesses-board"
          columns={@length}
          guesses={@guesses}
        />

        <.live_component
          module={ElixirWordleWeb.InputsBoard}
          id="inputs-board"
          attempts={@attempts}
          columns={@length}
        />
      </div>
    <% end %>

    <p class="adjust-content mx-auto text-center my-6" id="clue">
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

  def result_modal(assigns) do
    ~H"""
    <.modal id="results">
      <:title>
        <span class="text-center font-bold text-2xl  text-darkest_purple">
          You <% if @win?, do: " win", else: " lost" %> !
        </span>
      </:title>
      @wordle.
    </.modal>
    """
  end
end
