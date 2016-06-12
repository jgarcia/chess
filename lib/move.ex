defmodule Chess.Move do
  def valid?(piece, origin, destination) do
    piece
    |> strip_color
    |> valid_move?(origin, destination)
  end

  defp strip_color(piece) do
    piece
    |> Atom.to_string
    |> String.slice(1,1)
    |> String.to_atom
  end

  defp valid_move?(:P, {_, 2}, {_, 4}), do: true
  defp valid_move?(:P, {_, 7}, {_, 5}), do: true
  defp valid_move?(:P, {_, y1}, {_, y2}), do: abs(y2 - y1) == 1

  defp valid_move?(:B, {x1, y1}, {x2, y2}) do
    abs(int_value_of(x1) - int_value_of(x2)) == abs(y1 - y2)
  end

  defp valid_move?(:R, {x1, y1}, {x2, y2}) do
    x_delta = abs(int_value_of(x1) - int_value_of(x2))
    y_delta = abs(y1 - y2)

    case {x_delta, y_delta} do
      {0, _}  -> true
      {_, 0}  -> true
      _       -> false
    end
  end

  defp valid_move?(:K, {x1, y1}, {x2, y2}) do
    abs(y1 - y2) <= 1 && abs(int_value_of(x1) - int_value_of(x2)) <= 1
  end

  defp int_value_of(x_coord) do
    x_coord
    |> Atom.to_char_list
    |> Enum.at(0)
  end
end
