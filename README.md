# Elixir Wordle 

## Table of contents
1. [Game description](#game-description)
2. [Design](#design)
3. [Contributing](#contributing)


## Game description

In **Elixir Wordle**, **players try to guess an Elixir-related word based on the frequency of its letters in a web-based game**. 
The goal is to select the correct letters and arrange them in the correct order.

Each day, **a random word is chosen**, and players are given **two clues** to help them guess the word:
- The **length** indicated by a number of blank spaces.
- **A short phrase**. 

Players have **6 attempts** to guess the word, and if the word is of the correct length and a valid Elixir-related word, feedback is provided. 
**Incorrect letters** are displayed in **gray** (⬜), **correct letters** in **yellow** (🟨), and **correctly placed letters** in **green** (🟩).

The game continues until the player successfully guesses the word or exhausts all attempts.
Finally, the word is revealed and some information is given regarding it.

```
CLUE: "Datatype"

⬜⬜⬜⬜⬜ length(word) => 5 
⬜🟨⬜⬜🟨 Trying... 'FLOAT' => Now you know that contains 'L' and 'T'.
🟨⬜⬜🟨⬜ Trying... 'LISTS'
🟩⬜⬜🟨⬜ Trying... 'TREES' => Now you that the word starts with 'T'.
🟩🟩🟩🟩🟩 Trying... 'TUPLE' => Nice! :) 

INFO: Did you know that tuples store elements contiguously in memory? 
This means accessing a tuple element by index or getting the tuple size is a fast operation.
```

## Design
To access additional information about design, follow [the link](./docs/design.md).

## Contributing
Your contributions to this project are highly valued. If you have a suggestion for a new feature or encounter a bug, kindly open an issue or submit a pull request.
