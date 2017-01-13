defmodule Drom do
  def run(nil), do: nil
  def run(str) when is_bitstring(str) do
    cond do
      is_palindrom(str) -> str
      true ->
        case find_palindrom(str) do
          {:ok, palindrom} -> palindrom
          {:not_found} -> :not_found
        end
    end
  end

  def find_palindrom(str) when is_bitstring(str) do
    find_palindrom(str, 0, 2)
  end

  def find_palindrom(str, current_position, scan_len) do
    end_position = current_position + scan_len
    scan_range = current_position..end_position
    scanned_substr = String.slice(str, scan_range)

    # IO.inspect("$$$$$$$$")
    # IO.inspect("Str: #{str}")
    # IO.inspect("Current pos: #{current_position}")
    # IO.inspect("Scanned substr: #{scanned_substr}")
    # IO.inspect("$$$$$$$$")

    case is_palindrom(scanned_substr) do
      true -> {:ok, scanned_substr}
      :too_short -> :not_found
      _ -> find_palindrom(str, current_position + 1, scan_len)
    end
  end

  # a palindrom is at least 3 characters
  defp is_palindrom(str) when byte_size(str) < 3, do: :too_short
  defp is_palindrom(str) when is_bitstring(str) do
    String.reverse(str) == str
  end

  defp is_palindrom(str) when is_list(str) do
    Enum.join(str) |> is_palindrom
  end

  # def find_palindrom(str) when is_bitstring(str) do
  #   str
  #   |> String.graphemes
  #   |> find_palindrom
  # end

  # def find_palindrom([head|tail]) do
  #   find_palindrom(head, tail)
  # end

  # def find_palindrom(memo, []), do: :not_found
  # def find_palindrom(memo, [head|tail]) do
  #   IO.inspect("head #{memo}")
  #   IO.inspect("tail #{tail}")

  #   cond do
  #     is_palindrom(memo) -> {:ok, memo}
  #     is_palindrom(tail) -> {:ok, Enum.join(tail)}
  #     true -> find_palindrom("#{memo}#{head}", tail)
  #   end
  # end
end
