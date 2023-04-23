# Elixir Wordle
You can see the deployment result of main branch on:

<a href="https://elixir-wordle.fly.dev/">
<img src="https://img.shields.io/badge/-Elixir%20Wordle-purple"
alt="Visit the web">
</a>
            
## Table of contents

1. [Game description](#game-description)
2. [Running the game & tools used](#running-the-project)
3. [Design Info](#design-info)
4. [Contributing](#contributing)
5. [Contributors](#contributors)

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

## Running the project

**Prerequisites**: Elixir 1.14.1, Erlang/OTP 25.1, PostgreSQL.

1. Clone the repo: `git clone git@github.com:IciaCarroBarallobre/elixir_wordle.git`
2. Install dependencies: `mix deps.get`.
3. Configure DB, creation and migration:  `mix ecto.setup`(inside IEx).
4. Start Phoenix endpoint `mix phx.server` or `iex -S mix phx.server`(inside IEx).
5. Visit [`localhost:4000`](http://localhost:4000).

### Tools used
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)

The following tools were used in the development of this project:

- [Phoenix](https://www.phoenixframework.org/): an open-source web development framework written in the Elixir programming language.
- [PostgreSQL](https://www.postgresql.org/):  a free and open-source relational database management system (RDBMS) emphasizing extensibility and SQL compliance.
- [Wallaby](https://github.com/elixir-wallaby/wallaby): our end-to-end testing tool, which also allows us to take responsive screenshots [(here)](./docs/design.md). By default, test configuration excludes wallaby tests. To run only Wallaby tests, use the following command:

```elixir
mix test --only wallaby
```

## Design Info

For additional information about the design, please visit the following [link](./docs/design.md).

## Contributing

We value your contributions to this project. If you have suggestions for new features or encounter any bugs, please open an [issue](https://github.com/IciaCarroBarallobre/elixir_wordle/issues) or [fork](https://github.com/IciaCarroBarallobre/elixir_wordle/forks) the project and then submit a pull request.

[![GitHub issues by-label](https://img.shields.io/github/issues/badges/shields/good%20first%20issue)](https://github.com/badges/shields/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22)

## Contributors

This project was started thanks to the hack-a-thing session organized by [Elixir Newbie](https://www.elixirnewbie.com/). Many people from this same group (like @gcavanunez or @julioucla) have contributed after this session to it with commits, PR reviews, etc. So I am extremely grateful to all of them.
