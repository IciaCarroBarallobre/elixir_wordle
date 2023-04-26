defmodule ElixirWordleWeb.Rules do
  use ElixirWordleWeb, :live_component

  @moduledoc """
    Warnings about the game board.
  """

  def mount(socket) do
    {:ok, socket |> assign(animation: false)}
  end

  def render(assigns) do
    ~H"""
    <div id={"#{@id}-div"}>
      <.modal id={@id}>
        <:title>How to play</:title>

        <p class="my-4">
          In Elixir Wordle, players try to guess an Elixir-related word in a maximun of 6 tries.
          <br /> <br /> To start the game, enter any word:
        </p>

        <.live_component
          module={ElixirWordleWeb.GuessesBoard}
          id="example-guesses"
          columns={6}
          guesses={[{"erlang", [:match, :letter_match, :letter_match, :fail, :fail, :fail]}]}
          animation={false}
        />

        <div class="rounded-md bg-slate-50 m-5 px-4">
          <ul>
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
        </div>

        <.live_component
          module={ElixirWordleWeb.GuessesBoard}
          id="example-match"
          columns={6}
          guesses={[{"elixir", [:match, :match, :match, :match, :match, :match]}]}
          animation={false}
        />

        <p class="mx-auto text-center text-base mt-6 font-bold">Got it!</p>
      </.modal>
    </div>
    """
  end
end
