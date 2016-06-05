defmodule MoveTest do
  use ExUnit.Case
  alias Chess.Move

  ###
  # Pawn rules
  ###

  test "pawn movements" do
    assert Move.valid?(:wP, {:c, 2}, {:c, 4}) == true
    assert Move.valid?(:wP, {:c, 2}, {:c, 4}) == true
    assert Move.valid?(:wP, {:c, 2}, {:c, 5}) == false
    assert Move.valid?(:bP, {:c, 7}, {:c, 6}) == true
    assert Move.valid?(:bP, {:c, 7}, {:c, 5}) == true
    assert Move.valid?(:bP, {:c, 7}, {:c, 4}) == false
  end

  # test "bishop movements" do
  #   assert Move.valid?(:wB, {:c, 1}, {:e, 3}) == true
  #   assert Move.valid?(:wB, {:c, 1}, {:f, 4}) == true
  #   assert Move.valid?(:wB, {:c, 1}, {:d, 3}) == false
  # end

  # A bishop can only move in diagonal on the same tile color
  # A rook can only move in straight lines
  # A king can move in any direction one tile at a time
  # A pawn can only move forward
  # A Knight can only move in L direction
  # A queen can move in any direction without tile number limitation

end
