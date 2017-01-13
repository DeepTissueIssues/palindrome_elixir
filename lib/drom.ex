defmodule Drom do
  @min_palindrome_len 3

  defmacro not_scanning_entire_str(str, scan_len) do
    # scan_len != byte_size(str) - 1
    quote do
      unquote(scan_len) != byte_size(unquote(str)) - 1
    end
  end

  defmacro substr_already_scanned(str, current_pos, scan_len) do
    # ((current_pos + scan_len) >= byte_size(str) - 1),
    quote do
      ((unquote(current_pos) + unquote(scan_len)) >= byte_size(unquote(str)) - 1)
    end
  end

  def find(nil), do: nil
  def find(str) when is_bitstring(str) do
    find(str, 0, String.length(str) - 1, [])
  end

  defp find(str, current_pos, scan_len, found)
    when not_scanning_entire_str(str, scan_len)
    and  substr_already_scanned(str, current_pos, scan_len),
    do: find(str, 0, scan_len - 1, found)

  defp find(str, current_pos, scan_len, found) do
    scanned_substr = scan_substr(str, current_pos, scan_len)
    last_found = last_found(found)

    case is_palindrome(scanned_substr) do
      {true, :ok} when byte_size(scanned_substr) < byte_size(last_found) ->
        found
      {true, :ok} ->
        find(str, current_pos + 1, scan_len, [scanned_substr|found])
      {false, :too_short} when scan_len > (@min_palindrome_len - 1) ->
        find(str, 0, scan_len - 1, found)
      {false, :too_short} ->
        found
      _ ->
        find(str, current_pos + 1, scan_len, found)
    end
  end

  defp scan_substr(str, begin, scan_len) do
    str |> String.slice(begin..(begin + scan_len))
  end

  defp last_found(found) when is_list(found) and length(found) == 0, do: ""
  defp last_found([head|_]), do: head

  defp is_palindrome(str) when byte_size(str) < @min_palindrome_len do
    {false, :too_short}
  end

  defp is_palindrome(str) when is_bitstring(str) do
    {String.reverse(str) == str, :ok}
  end
end

