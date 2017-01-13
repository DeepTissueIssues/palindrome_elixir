defmodule DromTest do
  use ExUnit.Case
  doctest Drom

  test "returns nil when the string is nil" do
    str = nil
    assert Drom.run(str) == nil
  end

  test "when the string is a palindrom" do
    str = "aca"
    assert Drom.run(str) == str

    str = "ada"
    assert Drom.run(str) == str
  end

  test "when the palindrom is in the beginning" do
    str = "acablah"
    assert Drom.run(str) == "aca"
  end

  test "when the palindrom is in the middle" do
    str = "supacayoo"
    assert Drom.run(str) == "aca"
  end

  test "when the palindrom is in the end" do
    str = "supyo11aca"
    assert Drom.run(str) == "aca"
  end
end
