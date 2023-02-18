defmodule ElixirWordle.WordleServerMock do
  use GenServer

  @moduledoc """
    That's mimicking the behavior of a Wordle server, which can communicate
    with a database to retrieve a word and also provide feedback on a guess.
  """
  @static_answer %{
    answer: "sigil",
    clue: "Mechanisms for working with textual representations",
    explanation: ""
  }

  def start_link(_state) do
    GenServer.start_link(
      __MODULE__,
      @static_answer,
      name: __MODULE__
    )
  end

  # API
  def get_length_and_clue, do: GenServer.call(__MODULE__, :answer_and_clue)
  def feedback(guess), do: GenServer.call(__MODULE__, {:feedback, guess})

  ## Callbacks

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  def handle_call(:answer_and_clue, _from, %{answer: answer, clue: clue} = state) do
    {
      :reply,
      {:ok, %{length: String.length(answer), clue: clue}},
      state
    }
  end

  @impl true
  def handle_call({:feedback, guess}, _from, state) do
    {
      :reply,
      {:ok,
       %{
         guess: guess,
         feedback: for(_char <- 1..String.length(guess), do: :letter_match)
       }},
      state
    }
  end
end
