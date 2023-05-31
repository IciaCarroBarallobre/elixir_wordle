# Table of contents

- [Diagrams](#diagrams)
  1. [Flow diagram](#flow-diagram)
  2. [Sequence diagram](#sequence-diagram)

- [Mockups](#mockups)
- [Future ideas](#future-ideas)

## Diagrams

### Flow diagram

Main flow of the page per each day word:

```mermaid
  flowchart LR
  A(Start) --> B{Attempts is 0?}
  B ------> |Yes| E(Defeat)
  B --> |No| D[Try a word]
  D --> F{Same length as answer?}
  F --> |Yes| H{Is the answer?}
  H ----> |yes| I(Win)
  H --> |No| J[Give feedback]
  J --> |Attempts--|B
  F --> |No| G[Invalid word]
  G --> D
```

### Sequence diagram

Main sequence of the page, including layers interaction (browser, endpoints, db):

```mermaid
sequenceDiagram

    Client->> LVServer: Get / 

    loop Schedule every day
        LVServer->> Words: get_todays_word/0
        activate Words
        Words-->> LVServer: {ok, %{word, clue, description}}
        deactivate Words
    end

    LVServer -->> Client: /

    loop Attempts > 0  
        Client->> LVServer: Submit guess  
        LVServer ->> Wordle: feedback(guess, word)
        activate Wordle
        Wordle -->> LVServer: feedback
        deactivate Wordle
        LVServer -->> Client: Guess feedback  
    end
```

## Mockups

| <img width="500px" alt="Mockup of wordle page" src="/docs/images/mockups/page1.png" /> | <img width="430px" alt="Mockup of end game page" src="/docs/images/mockups/page2.png" /> |
| -- | -- |

For the MVP feature like setting the language, color-blind model, keyboard feedback, only valid words and dark theme, are not necessary.

### Frontend Screenshots  (responsive)

Table displaying wallaby screenshots with 640px width:

| <img width="500px" alt="Screenshot of wordle page 640px width when word is available" src="/docs/images/screenshots/screenshot-w-640.png" /> |  <img width="500px" alt="Screenshot of wordle page when word is not available" src="/docs/images/screenshots/screenshot-unavailable-word-w-640.png" /> |
| -- | -- |
| <img width="500px" alt="Screenshot of wordle page 640px width when rules are displayed" src="/docs/images/screenshots/screenshot-rules-w-640.png" /> | <img width="500px" alt="Screenshot of wordle page 640px width when rules are displayed" src="/docs/images/screenshots/screenshot-results-w-640.png" /> |

To examine additional widths, please refer to the [screenshots folder](./images/screenshots/).

[Wallaby](https://github.com/elixir-wallaby/wallaby) is used for end-to-end testing and for taking these screenshots (with Chrome drivers).

To produce the screenshots and evaluate client-server cross-functional behaviors comprehensively:

```elixir
mix test --only wallaby
```

### Future ideas

Take into account ...

- Words considered valid are extracted using regex from a specific version of the [Elixir repository](https://github.com/elixir-lang/elixir/tags), specified in the [.env](/.env) file.
