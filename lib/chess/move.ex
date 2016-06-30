defmodule Chess.Move do
  def valid?(piece, origin, destination) do
    piece
    |> strip_color
    |> valid_move?(origin, destination)
  end

  defp valid_move?(:P, {_, 2}, {_, 4}), do: true
  defp valid_move?(:P, {_, 7}, {_, 5}), do: true
  defp valid_move?(:P, {_, y1}, {_, y2}), do: abs(y2 - y1) == 1

  defp valid_move?(:B, origin, destination) do
    delta_x(origin, destination) == delta_y(origin, destination)
  end

  defp valid_move?(:R, origin, destination) do
    case {delta_x(origin, destination), delta_y(origin, destination)} do
      {0, _}  -> true
      {_, 0}  -> true
      _       -> false
    end
  end

  defp valid_move?(:K, origin, destination) do
    delta_y(origin, destination) <= 1 && delta_x(origin, destination) <= 1
  end

  defp valid_move?(:N, origin, destination) do
    case {delta_x(origin, destination), delta_y(origin, destination)} do
      {2, 1}  -> true
      {1, 2}  -> true
      _       -> false
    end
  end

  defp valid_move?(:Q, origin, destination) do
    case {delta_x(origin, destination), delta_y(origin, destination)} do
      {0, _} -> true
      {_, 0} -> true
      {x, y} -> x - y == 0
    end
  end

  defp delta_x({x1, _}, {x2, _}), do: abs(int_value_of(x1) - int_value_of(x2))
  defp delta_y({_, y1}, {_, y2}), do: abs(y1 - y2)

  defp int_value_of(x_coord) do
    x_coord
    |> Atom.to_char_list
    |> Enum.at(0)
  end

  defp strip_color(piece) do
    piece
    |> Atom.to_string
    |> String.slice(1,1)
    |> String.to_atom
  end
end
