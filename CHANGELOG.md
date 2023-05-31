# ChangeLog

## Version 0.2.0

- Fixing the issue where creating unrealistic dates, such as adding 1 day to today's date resulting in a date like 32.

### Documentation

- Diagrams to Mermaid diagrams.

## Version 0.1.0

### Frontend

- JS keyboard binding with Alpine.js, allowing the inputs-board to accept input from both on-screen and external keyboards.
- Displayed guesses on the screen with animations.
- Added a hook to control guesses and prevent unnecessary data overload on the server by not sending data when the attempt number is 0 or not enough length guesses.
- Implemented a color feedback system with animation.
- Message popup for cases such as exceeding the maximum number of attempts, entering too few or too many letters.
- Handled unavailable words.
- Added modals for rules and for results, which include next word info.
- Get next word info each day.
- The server handles all possible events, although the client only sends events when necessary.
- Created components including a button panel for modals, modals (rules, results), warning messages, keyboard, boards (input-board, guesses board), and footer.
- Copy & Share result button on the 2nd page.

### Backend

- Implemented the Wordle logic for handling a play, including attempts, guesses and feedback, ends, etc.
- Added words contexts and schema, where the retrieve word logic is implemented.
- DB seeding.

### Tests

- Added a test for backend word context.
- Added a test for frontend flow, doing a mock for words context.
- Implemented Wallaby end-to-end tests.

### Documentation

- Included mockups and diagrams.
- Added a README with instructions on how to run the project and an index to the rest of the documentation.
