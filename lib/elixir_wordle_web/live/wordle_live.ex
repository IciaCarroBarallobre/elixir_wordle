defmodule ElixirWordleWeb.WordleLive do
  use ElixirWordleWeb, :live_view
  alias ElixirWordle.WordleServerMock, as: WordleServerMock
  @max_attempts 6

  def mount(_params, _session, socket) do
    {response, info} = WordleServerMock.get_length_and_clue()

    case response do
      :ok ->
        %{length: length, clue: clue} = info

        {:ok,
         socket
         |> assign(
           guesses: [],
           attempts: @max_attempts,
           message: %{},
           length: length,
           clue: clue
         )}

      :error ->
        %{error: error_msg} = info

        {:ok,
         socket
         |> assign(
           guesses: [],
           attempts: 0,
           message: %{error: error_msg},
           length: 0,
           clue: ""
         )}
    end
  end

  def handle_event("submit", %{"guess" => guess}, socket) do
    cond do
      socket.assigns.attempts == 0 ->
        {:noreply, assign(socket, message: %{error: "No more attempts"})}

      String.length(guess) < socket.assigns.length ->
        {:noreply, assign(socket, message: %{error: "Not enough letters"})}

      true ->
        {response, info} = WordleServerMock.feedback(guess)

        case response do
          :ok ->
            %{guess: guess, feedback: feedback} = info
            number_of_attempts = socket.assigns.attempts - 1

            {
              :noreply,
              socket
              |> assign(
                guesses: [{guess, feedback} | socket.assigns.guesses],
                attempts: number_of_attempts
              )
              |> push_event("new_attempt", %{attempts: number_of_attempts})
            }

          :error ->
            %{error: error_msg} = info
            {:noreply, socket |> assign(message: %{error: error_msg})}
        end
    end
  end

  def render(assigns) do
    ~H"""
    <p class="bg-slate-100 rounded adjust-content mx-auto text-center w-fit px-2 mt-2 mb-6">
      Play a version of Wordle where <strong> all the words are related to Elixir</strong>.
    </p>

    <.live_component module={ElixirWordleWeb.PopupOfBoard} id="popupofboard" message={@message} />

    <div id="board" class=" grid grid-cols-1 gap-y-1">
      <.live_component
        module={ElixirWordleWeb.GuessesBoard}
        id="guesses"
        word_max_length={@length}
        guesses={@guesses}
      />

      <.live_component
        module={ElixirWordleWeb.InputsBoard}
        id="inputs"
        attempts={@attempts}
        word_max_length={@length}
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
