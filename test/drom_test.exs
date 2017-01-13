defmodule DromTest do
  use ExUnit.Case
  doctest Drom

  # test "returns nil when the string is nil" do
  #   str = nil
  #   assert Drom.find_palindrome(str) == nil
  # end

  # test "when the string is a palindrome" do
  #   str = "aca"
  #   assert Drom.find_palindrome(str) == {:ok, str}

  #   str = "ada"
  #   assert Drom.find_palindrome(str) == {:ok, str}
  # end

  # test "when the palindrome is in the beginning" do
  #   str = "acablah"
  #   assert Drom.find_palindrome(str) == {:ok, "aca"}
  # end

  # test "when the palindrome is in the middle" do
  #   str = "supacayoo"
  #   assert Drom.find_palindrome(str) == {:ok, "aca"}
  # end

  # test "when the palindrome is in the end" do
  #   str = "supyo11aca"
  #   assert Drom.find_palindrome(str) == {:ok, "aca"}
  # end

  # test "when the palindrome is longer" do
  #   str = "acaoooioooblah"
  #   assert Drom.find_palindrome(str) == {:ok, "oooiooo"}
  # end

  # test "when there are no palindromes" do
  #   str = "123456"
  #   assert Drom.find_palindrome(str) == :not_found
  # end

  # test "when the long str is a palindrome" do
  #   str = "abdedba"
  #   assert Drom.find_palindrome(str) == {:ok, str}
  # end

  test "when there are more than one palindrome, find the first one" do
    str = "abracadabra"
    assert Drom.find_palindrome(str) == {:ok, "aca"}
  end
end
