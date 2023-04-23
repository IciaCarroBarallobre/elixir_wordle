# Elixir Wordle
You can see the deployment result of main branch on:

[![ElixirWordle](https://img.shields.io/badge/elixir_wordle_link-%23990599.svg?style=for-the-badge)](https://elixir-wordle.fly.dev/)

[![GitHub version](https://badge.fury.io/gh/IciaCarroBarallobre%2Felixir_wordle.svg)](https://github.com/IciaCarroBarallobre/elixir_wordle)
## Table of contents

1. [Game description](#game-description) 🎲
2. [Running the game & tools used](#running-the-project) ⚒️
3. [Design Info](#design-info) 📋
4. [Contributing](#contributing) 💬
5. [Contributors](#contributors) 👥

## Game description

**Elixir Wordle** is a game that can be played on the web, where players aim to **guess a word related to Elixir programming language**. 

**Every day, a random word is chosen**, and players are given **the word's length**, **a clue**, and **six chances** to guess the word. After each guess, players receive **feedback to help them** narrow down the possibilities and make a more informed guess.

Example:
- **Incorrect letters** are displayed in **gray** (⬜).
- **Correct letters** in **yellow** (🟨).
- **Correctly placed letters** in **green** (🟩).

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
3. Configure DB, creation and migration:  `mix ecto.setup`.
4. Start Phoenix endpoint `mix phx.server` or `iex -S mix phx.server`(inside IEx).
5. Visit [`localhost:4000`](http://localhost:4000).

### Tools used
[![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Phoenix](https://img.shields.io/badge/phoenix-%23994709.svg?style=for-the-badge)](https://www.phoenixframework.org/)
[![Wallaby](https://img.shields.io/badge/wallaby-%23797900.svg?style=for-the-badge
)](https://github.com/elixir-wallaby/wallaby)

The following tools were used in the development of this project:

- [Phoenix](https://www.phoenixframework.org/): an open-source web development framework written in the Elixir programming language.
- [PostgreSQL](https://www.postgresql.org/):  a free and open-source relational database management system (RDBMS) emphasizing extensibility and SQL compliance.
- [Wallaby](https://github.com/elixir-wallaby/wallaby): our end-to-end testing tool, which also allows us to take [responsive screenshots](./docs/design.md). By default, test configuration excludes wallaby tests. To run only Wallaby tests, use the following command:

```elixir
mix test --only wallaby
```

## Design Info

For additional [documentation about the design](./docs/design.md) like:
- Mockups  📱
- Flow diagram 📊
- Sequence diagram 📊

## Contributing

💬 We value your contributions to this project. If you have suggestions for new features or encounter any bugs, please open an [issue](https://github.com/IciaCarroBarallobre/elixir_wordle/issues) or [fork](https://github.com/IciaCarroBarallobre/elixir_wordle/forks) the project and then submit a pull request.

[![GitHub issues](https://img.shields.io/github/issues/IciaCarroBarallobre/elixir_wordle.svg)](https://GitHub.com/IciaCarroBarallobre/elixir_wordle/issues/)
[![GitHub issues by-label](https://img.shields.io/github/issues/IciaCarroBarallobre/elixir_wordle/good%20first%20issue)](https://github.com/IciaCarroBarallobre/elixir_wordle/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22)

[![GitHub forks](https://img.shields.io/github/forks/IciaCarroBarallobre/elixir_wordle.svg?style=social&label=Fork&maxAge=2592000)](https://GitHub.com/IciaCarroBarallobre/elixir_wordle/network/)

## Contributors

👥 This project was started thanks to the hack-a-thing session organized by [Elixir Newbie](https://www.elixirnewbie.com/). Many people from this same group (like @gcavanunez or @julioucla) have contributed after this session to it with commits, PR reviews, etc. So I am extremely grateful to all of them. 💜
