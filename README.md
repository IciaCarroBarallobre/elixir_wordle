# Elixir Wordle

## Table of contents

1. [Game description](#game-description)
2. [Running the game & tools used](#running-the-game)
3. [Design Info](#design-info)
4. [Contributing](#contributing)

## Game description

**Elixir Wordle** is a **web-based game** where players attempt to **guess an Elixir-related word** based on the frequency of its letters. The objective is to choose the **correct letters** and arrange them **in the correct order**.

**Each day, a random word is selected**, and players are provided with two clues to help them guess the word:

- **The word's length**, indicated by a number of blank spaces.
- **A short phrase**.

Players have **six attempts to guess the word**, and if they correctly guess a valid Elixir-related word of the correct length, feedback is provided.

Example where **incorrect letters** are displayed in **gray** (⬜), **correct letters** in **yellow** (🟨), and **correctly placed letters** in **green** (🟩):

```bash
CLUE: "Datatype"

⬜⬜⬜⬜⬜ length(word) => 5 
⬜🟨⬜⬜🟨 Trying... 'FLOAT' => Now you know that contains 'L' and 'T'.
🟨⬜⬜🟨⬜ Trying... 'LISTS'
🟩⬜⬜🟨⬜ Trying... 'TREES' => Now you know the word starts with 'T'.
🟩🟩🟩🟩🟩 Trying... 'TUPLE' => You got it!
```

## Running the game

To start your Phoenix server:

1. Install dependencies: `mix deps.get`.
2. Start Phoenix endpoint `mix phx.server` or `iex -S mix phx.server`(inside IEx).
3. Visit [`localhost:4000`](http://localhost:4000).

### Tools used

The following tools were used in the development of this project:

- [Phoenix](https://www.phoenixframework.org/): an open-source web development framework written in the Elixir programming language.
- [Wallaby](https://github.com/elixir-wallaby/wallaby): our end-to-end testing tool, which also allows us to take responsive screenshots [(here)](./docs/design.md). By default, test configuration excludes wallaby tests. To run only Wallaby tests, use the following command:

```elixir
mix test --only wallaby
```

## Design Info

For additional information about the design, please visit the following [link](./docs/design.md).

## Contributing

We value your contributions to this project. If you have suggestions for new features or encounter any bugs, please open an issue or fork the project and then submit a pull request.
