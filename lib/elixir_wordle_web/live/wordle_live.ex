defmodule ElixirWordleWeb.WordleLive do
  use ElixirWordleWeb, :live_view
  import ElixirWordleWeb.ErrorComponents

  alias ElixirWordle.Wordle

  @words Application.compile_env(:elixir_wordle, :words_api, ElixirWordle.Words)

  defguard is_valid_size?(word) when byte_size(word) > 2 and byte_size(word) < 9

  def new_game(socket) do
    schedule(:next_word)

    case @words.get_todays_word() do
      {:ok, %{word: word, clue: clue, description: desc}} when is_valid_size?(word) ->
        socket
        |> assign(
          is_valid_word?: true,
          game: %Wordle{answer: word, clue: clue, description: desc},
          msg: nil
        )
        |> push_event("new_attempt", %{length: String.length(word)})

      _ ->
        socket
        |> assign(
          is_valid_word?: false,
          msg: "Today's word is not available",
          game: nil,
          err_img: "Word not available"
        )
        |> push_event("no_more_attempts", %{})
    end
  end

  def mount(_params, _session, socket), do: {:ok, socket |> new_game()}

  def handle_event("submit", %{"guess" => guess}, %{assigns: %{game: old_game}} = socket) do
    case Wordle.play(old_game, guess) do
      {:ok, game} ->
        if Wordle.is_end?(game) do
          schedule(:ends)

          {
            :noreply,
            socket
            |> assign(game: game, msg: "You #{(game.win? && "won") || "lost"} !")
            |> assign(current_time: DateTime.utc_now())
            |> push_event("no_more_attempts", %{})
          }
        else
          {
            :noreply,
            socket
            |> assign(game: game)
            |> push_event("new_attempt", %{length: String.length(game.answer)})
          }
        end

      {:error, msg} ->
        {:noreply, socket |> assign(msg: msg)}

      _ ->
        {:noreply, socket |> assign(msg: "Error")}
    end
  end

  def handle_info(:ends, socket) do
    schedule(:update_clock)
    {:noreply, socket |> assign(ends?: true)}
  end

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
        <.live_component module={ElixirWordleWeb.PopupOfBoard} id="warningMessage" message={@msg} />

        <.live_component
          module={ElixirWordleWeb.GuessesBoard}
          id="guesses-board"
          columns={String.length(@game.answer)}
          guesses={@game.guesses}
        />

        <.live_component
          module={ElixirWordleWeb.InputsBoard}
          id="inputs-board"
          attempts={@game.attempts}
          columns={String.length(@game.answer)}
          end?={Wordle.is_end?(@game)}
        />
      </div>
    <% else %>
      <div id="error" class="mx-auto space-y-1 max-w-xs w-4/5">
        <.image_error text={@err_img} id="image_error" />
      </div>
    <% end %>

    <p id="clue" class="adjust-content mx-auto text-center my-6 mt-4
       w-full xl:w-2/3 md:w-4/5">
      Clue: <strong><%= if is_nil(@game), do: @msg, else: @game.clue %></strong>
    </p>

    <.live_component module={ElixirWordleWeb.Keyboard} id="keyboard" />
    """
  end

  def menu_panel(assigns) do
    ~H"""
    <.panel buttons_info={[
      {"results", :chart_bar, if(@game, do: Wordle.is_end?(@game), else: false)},
      {"wordle-rules", :question_mark_circle, true}
    ]} />

    <.live_component module={ElixirWordleWeb.Rules} id="wordle-rules" />
    <%= if not is_nil(@game) and Wordle.is_end?(@game) do %>
      <.live_component
        module={ElixirWordleWeb.Results}
        id="results"
        word={@game.answer}
        description={@game.description}
        win?={@game.win?}
        feedback={get_feedback(@game.guesses)}
        show={true}
        current_time={@current_time}
      />
    <% end %>
    """
  end

  defp get_feedback(guesses), do: for({_word, feedback} <- guesses, do: feedback)

  defp schedule(:next_word),
    do: Process.send_after(self(), :next_word, get_ms_for_tomorrow() + 2000)

  defp schedule(:update_clock), do: Process.send_after(self(), :update_clock, 1000)

  defp schedule(:ends), do: Process.send_after(self(), :ends, get_ends_modal_delay())

  defp get_ends_modal_delay, do: Application.get_env(:elixir_wordle, :end_delay, 1700)

  defp get_ms_for_tomorrow() do
    today = DateTime.utc_now()
    tomorrow = %{DateTime.add(today, 1, :day) | hour: 0, minute: 0, second: 0}
    DateTime.diff(tomorrow, today) * 1000
  end
end
