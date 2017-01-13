defmodule Drom do
  def find_palindrome(nil), do: nil
  def find_palindrome(str) when is_bitstring(str) do
    find_palindrome(str, 0, String.length(str) - 1)
  end

  defp find_palindrome(str, current_position, scan_len) do
    end_position = current_position + scan_len
    scanned_substr = String.slice(str, current_position..end_position)

    case is_palindrome(scanned_substr) do
      true -> {:ok, scanned_substr}
      :too_short when scan_len > 2 ->
        find_palindrome(str, 0, scan_len - 1)
      :too_short -> :not_found
      _ -> find_palindrome(str, current_position + 1, scan_len)
    end
  end

  # a palindrome is at least 3 characters
  defp is_palindrome(str) when byte_size(str) < 3, do: :too_short
  defp is_palindrome(str) when is_bitstring(str) do
    String.reverse(str) == str
  end
end

