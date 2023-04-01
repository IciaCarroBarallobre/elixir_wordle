defmodule ElixirWordleWeb.Rules do
  use ElixirWordleWeb, :live_component

  @moduledoc """
    Warnings about the game board.
  """

  def render(assigns) do
    ~H"""
    <div id={"#{@id}-div"}>
      <.modal id={@id}>
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
    </div>
    """
  end
end
