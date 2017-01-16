defmodule Drom do
  @min_palindrome_len 3

  def find(nil), do: nil
  def find(str) when is_bitstring(str) do
    _find(str, 0, byte_size(str) - 1, [], 0)
  end

  # no way there are more palindromes long enough
  # the next node down is useless, back out of this branch and start a new branch
  defp _find(_str, current_pos, end_pos, found, longest)
    when current_pos == 0
    and  end_pos + 1 < longest,
    do: found

  defp _find(str, current_pos, end_pos, found, longest)
    when current_pos != 0
    and  (end_pos - current_pos + 1) < longest,
    do: _find(str, 0, end_pos - 1, found, longest)

  defp _find(str, current_pos, end_pos, found, longest) do
    substr = String.slice(str, current_pos..end_pos)

    case is_palindrome(substr) do
      {true, :ok} when byte_size(substr) < longest ->
        found
      {true, :ok} when byte_size(substr) > longest ->
        _find(str, 0, end_pos - 1, [substr], byte_size(substr))
      {true, :ok} ->
        _find(str, 0, end_pos - 1, [substr|found], byte_size(substr))
      {false, :too_short} when end_pos > (@min_palindrome_len - 1) ->
        _find(str, 0, end_pos - 1, found, longest)
      {false, :too_short} ->
        found
      {false, :ok} ->
        _find(str, current_pos + 1, end_pos, found, longest)
    end
  end

  defp is_palindrome(str)
    when byte_size(str) < @min_palindrome_len,
    do: {false, :too_short}

  defp is_palindrome(str)
    when is_bitstring(str),
    do: {String.reverse(str) == str, :ok}

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

