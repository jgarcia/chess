defmodule Chess.Move do
  def valid?(piece, origin, destination) do
    valid_move? :P, origin, destination
  end

  defp valid_move?(:P, {_, 2}, {_, 4}), do: true
  defp valid_move?(:P, {_, 7}, {_, 5}), do: true
  defp valid_move?(:P, {_, y1}, {_, y2}), do: abs(y2 - y1) == 1
end
