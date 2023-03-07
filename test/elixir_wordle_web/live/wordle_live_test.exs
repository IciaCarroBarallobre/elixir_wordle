defmodule ElixirWordleWeb.WordleLiveTest do
  use ExUnit.Case
  use ElixirWordleWeb.ConnCase, async: true

  describe "Popup of Board: error msg when submit (keyboard)" do
    test "Too many letters"
    test "Not enough letter"
    test "Delete msg if key-press"
  end

  describe "Guesses & Inputs" do
    test "Consistent number of attempts: with 0 guesses, we have the maximum number of entries left."
    test "Consistent number of attempts: With maximum number of guesses, we have 0 entries left."
    test "Consistent number of attempts: with n guesses .. inputs = attempts - n guesses"
  end
end
