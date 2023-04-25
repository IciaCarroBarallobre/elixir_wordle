defmodule ElixirWordleWeb.WordleLive do
  use ElixirWordleWeb, :live_view
  import ElixirWordleWeb.ErrorComponents

  @max_attempts 6
  @wordle Application.compile_env(:elixir_wordle, :wordle_api, ElixirWordle.Wordle)

  defguard is_valid_size?(word) when byte_size(word) > 2 and byte_size(word) < 9

  def new_game(socket) do
    schedule(:next_word)

    socket =
      socket
      |> assign(
        is_valid_word?: false,
        ends?: false,
        win?: false
      )

    case @wordle.get_word_info() do
      {:ok, %{word: answer, clue: clue, description: description}}
      when is_valid_size?(answer) ->
        socket
        |> assign(
          is_valid_word?: true,
          answer: answer,
          clue: clue,
          description: description,
          guesses: [],
          attempts: @max_attempts,
          message: nil
        )
        |> push_event("new_attempt", %{attempts: true})
        |> push_event("set_length", %{length: String.length(answer)})

      _ ->
        socket
        |> assign(
          clue: "Today's word is not available",
          image_error_msg: "Word not available",
          attempts: 0,
          is_valid_word?: false
        )
        |> push_event("new_attempt", %{attempts: false})
    end
  end

  def mount(_params, _session, socket) do
    schedule(:update_clock)

    {:ok, socket |> new_game() |> assign(current_time: DateTime.utc_now())}
  end

  def handle_event("submit", %{"guess" => _guess}, %{assigns: %{attempts: 0}} = socket),
    do: {:noreply, assign(socket, message: "There aren't more attempts")}

  def handle_event("submit", %{"guess" => guess}, %{assigns: %{answer: answer}} = socket)
      when byte_size(answer) > byte_size(guess),
      do: {:noreply, assign(socket, message: "Not enough letters")}

  def handle_event(
        "submit",
        %{"guess" => guess},
        %{assigns: %{attempts: attempts, guesses: guesses, answer: answer}} = socket
      ) do
    guess = guess |> trim(String.length(answer))

    with {:ok, %{guess: guess, feedback: feedback}} <- @wordle.feedback(guess, answer),
         win? <- Enum.all?(feedback, fn x -> x == :match end),
         lost? <- Enum.any?(feedback, fn x -> x != :match end) and attempts == 1 do
      if win? or lost? do
        Process.send_after(self(), :ends, get_ends_modal_delay())

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
      {:error, error_msg} ->
        {:noreply, socket |> assign(message: %{error: error_msg})}

      _ ->
        {:noreply, socket |> assign(message: %{error: "Error"})}
    end
  end

  def handle_info(:ends, socket), do: {:noreply, socket |> assign(ends?: true)}

  def handle_info(:next_word, socket), do: {:noreply, socket |> new_game()}

  def handle_info(:update_clock, socket) do
    schedule(:update_clock)
    {:noreply, socket |> assign(current_time: DateTime.utc_now())}
  end

  def render(assigns) do
    ~H"""
    <%= menu_panel(assigns) %>

    <p class="bg-slate-100 rounded adjust-content text-center mx-auto mt-2 mb-5
     w-full xl:w-2/3 md:w-4/5">
      Play a version of Wordle where <strong> all <br /> the words are related to Elixir</strong>.
    </p>

    <%= if @is_valid_word? do %>
      <div id="board" class=" grid grid-cols-1 gap-y-1 relative">
        <.live_component module={ElixirWordleWeb.PopupOfBoard} id="warningMessage" message={@message} />

        <.live_component
          module={ElixirWordleWeb.GuessesBoard}
          id="guesses-board"
          columns={String.length(@answer)}
          guesses={@guesses}
        />

        <.live_component
          module={ElixirWordleWeb.InputsBoard}
          id="inputs-board"
          attempts={@attempts}
          columns={String.length(@answer)}
        />
      </div>
    <% else %>
      <div id="error" class="mx-auto space-y-1 max-w-xs w-4/5">
        <.image_error text={@image_error_msg} id="image_error" />
      </div>
    <% end %>

    <p id="clue" class="adjust-content mx-auto text-center my-6 mt-4
       w-full xl:w-2/3 md:w-4/5">
      Clue: <strong><%= @clue %></strong>
    </p>

    <.live_component module={ElixirWordleWeb.Keyboard} id="keyboard" />
    """
  end

  def menu_panel(assigns) do
    ~H"""
    <.panel buttons_info={[
      {"results", :chart_bar, @ends?},
      {"wordle-rules", :question_mark_circle, true}
    ]} />

    <.live_component module={ElixirWordleWeb.Rules} id="wordle-rules" />
    <%= if @ends? do %>
      <.live_component
        module={ElixirWordleWeb.Results}
        id="results"
        word={@answer}
        description={@description}
        win?={@win?}
        feedback={get_guesses_feedback(@guesses)}
        show={true}
        current_time={@current_time}
      />
    <% end %>
    """
  end

  defp fill_guesses(guesses, 0), do: guesses

  defp fill_guesses([{guess, _feedback} | _t] = guesses, attempts) when attempts > 0 do
    word = for _i <- 1..String.length(guess), do: " ", into: ""
    fill_guesses([{word, nil} | guesses], attempts - 1)
  end

  defp get_guesses_feedback(guesses),
    do: for({_guess, feedback} <- guesses, not is_nil(feedback), do: feedback)

  defp get_ends_modal_delay, do: Application.get_env(:elixir_wordle, :end_delay, 1700)

  defp get_ms_for_tomorrow() do
    today = DateTime.utc_now()
    tomorrow = %{today | day: today.day + 1, hour: 0, minute: 0, second: 0}
    DateTime.diff(tomorrow, today) * 1000
  end

  defp trim(word, length), do: word |> String.slice(0..(length - 1))

  defp schedule(:next_word),
    do: Process.send_after(self(), :next_word, get_ms_for_tomorrow() + 2000)

  defp schedule(:update_clock), do: Process.send_after(self(), :update_clock, 1000)
end
