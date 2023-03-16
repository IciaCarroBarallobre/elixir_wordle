defmodule ElixirWordleWeb.WordleLive do
  use ElixirWordleWeb, :live_view

  @max_attempts 6
  @wordle Application.compile_env(:elixir_wordle, :wordle, ElixirWordle.Wordle)

  def mount(_params, _session, socket) do
    case @wordle.get_length_and_clue() do
      {:ok, %{length: length, clue: clue}} ->
        {:ok,
         socket
         |> assign(guesses: [], attempts: @max_attempts, message: nil, length: length, clue: clue)}

      {:error, %{error: error_msg}} ->
        {:ok,
         socket
         |> assign(guesses: [], attempts: 0, message: error_msg, length: 0, clue: "clue")}
    end
  end

  def handle_event("submit", %{"guess" => _guess}, %{assigns: %{attempts: 0}} = socket) do
    {:noreply, assign(socket, message: "No more attempts")}
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
        attempts = attempts - 1

        {
          :noreply,
          socket
          |> assign(guesses: [{guess, feedback} | guesses], attempts: attempts)
          |> push_event("new_attempt", %{attempts: attempts})
        }

      {:error, %{error: error_msg}} ->
        {:noreply, socket |> assign(message: %{error: error_msg})}
    end
  end

  def render(assigns) do
    ~H"""
    <p class="bg-slate-100 rounded adjust-content mx-auto text-center w-fit px-2 mt-2 mb-6">
      Play a version of Wordle where <strong> all the words are related to Elixir</strong>.
    </p>

    <.live_component module={ElixirWordleWeb.PopupOfBoard} id="warningMessage" message={@message} />

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
end
