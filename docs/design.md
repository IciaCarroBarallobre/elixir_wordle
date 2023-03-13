# Table of contents

- [Diagrams](#diagrams)
  1. [Flow diagram](#flow-diagram)
  2. [Sequence diagram](#sequence-diagram)

- [Mockups](#mockups)
- [Other ideas](#other-ideas)

## Diagrams

### Flow diagram

Main flow of the page:

![Flow Diagram](/docs/images/diagrams/flow_diagram.png)

### Sequence diagram

Main sequence of the page, including layers interation (browser, endpoints, ..., db): TODO

![Sequence Diagram]("/docs/images/diagrams/sequence_diagram.png")

## Mockups

| <img width="500px" alt="Mockup of wordle page" src="/docs/images/mockups/page1.png" /> | <img width="430px" alt="Mockup of end game page" src="/docs/images/mockups/page2.png" /> |
| -- | -- |

### Frontend Screenshots  (responsive)

Table displaying wallaby screenshots with responsive widths:

| width = 640px <img width="500px" alt="Screenshot of wordle page width = 640px" src="/docs/images/screenshots/screenshot-w-640.png" /> | width = 768px <img width="500px" alt="Screenshot of wordle page width = 768px" src="/docs/images/screenshots/screenshot-w-768.png" /> |
| -- | -- |
| width = 1024px  <img width="500px" alt="Screenshot of wordle page width = 1024px" src="/docs/images/screenshots/screenshot-w-1024.png" /> |  |

[Wallaby](https://github.com/elixir-wallaby/wallaby) is used for end-to-end testing and for taking these screenshots (with Chrome drivers).

To generate it:

```elixir
mix test --only wallaby
```

### Other ideas

Take into account ...

- Words considered valid are extracted using regex from a specific version of the [Elixir repository](https://github.com/elixir-lang/elixir/tags), specified in the [.env](/.env) file.
- If we specify the keyboard on the page, we will clearly indicate the possible input.
