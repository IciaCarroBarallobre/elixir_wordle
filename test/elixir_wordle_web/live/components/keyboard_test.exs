defmodule ElixirWordleWeb.KeyboardTest do
  use ExUnit.Case
  use ElixirWordleWeb.ConnCase, async: true

  @tag :wallaby
  test "external keyboard event trigger on-screen keyboard"
end
