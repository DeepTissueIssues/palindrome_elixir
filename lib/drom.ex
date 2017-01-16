defmodule Drom do
  @min_palindrome_len 3

  #######################
  # custom guard clause #
  #######################

  defmacro substr_too_short(current_pos, end_pos, longest) do
    quote do
      (unquote(end_pos) - unquote(current_pos) + 1) < unquote(longest)
    end
  end

  ##############
  # public API #
  ##############

  def find(nil), do: nil
  def find(str) when is_bitstring(str) do
    _find(str, 0, byte_size(str) - 1, [], @min_palindrome_len)
  end

  ###########
  # private #
  ###########

  defp _find(_str, current_pos, end_pos, found, longest)
    when current_pos == 0
    and substr_too_short(current_pos, end_pos, longest),
    do: found

  defp _find(str, current_pos, end_pos, found, longest)
    when current_pos != 0
    and substr_too_short(current_pos, end_pos, longest),
    do: _find(str, 0, end_pos - 1, found, longest)

  defp _find(str, current_pos, end_pos, found, longest) do
    substr = String.slice(str, current_pos..end_pos)

    case is_palindrome(substr) do
      true when byte_size(substr) < longest ->
        found
      true when byte_size(substr) > longest ->
        _find(str, 0, end_pos - 1, [substr], byte_size(substr))
      true ->
        _find(str, 0, end_pos - 1, [substr|found], byte_size(substr))
      false ->
        _find(str, current_pos + 1, end_pos, found, longest)
    end
  end

  defp is_palindrome(str)
    when is_bitstring(str),
    do: String.reverse(str) == str

  defp debug(str, substr, current_pos, end_pos, found, longest) do
    IO.puts("===================")
    IO.puts("Str: #{str}")
    IO.puts("Substr: #{substr}")
    IO.puts("Current Pos: #{current_pos}")
    IO.puts("Scan Len: #{end_pos}")
    IO.puts("Longest: #{longest}")
    IO.puts("Found: #{found}")
  end
end

