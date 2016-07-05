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

  test "bishop movements" do
    assert Move.valid?(:wB, {:c, 1}, {:e, 3}) == true
    assert Move.valid?(:wB, {:c, 1}, {:f, 4}) == true
    assert Move.valid?(:wB, {:c, 1}, {:d, 3}) == false
  end

  test "rook movements" do
    assert Move.valid?(:wR, {:a, 1}, {:a, 8}) == true
    assert Move.valid?(:wR, {:a, 1}, {:c, 8}) == false
    assert Move.valid?(:wR, {:a, 1}, {:h, 1}) == true
  end

  test "king movements" do
    assert Move.valid?(:wK, {:b, 2}, {:a, 3}) == true
    assert Move.valid?(:wK, {:b, 2}, {:b, 3}) == true
    assert Move.valid?(:wK, {:b, 2}, {:c, 3}) == true
    assert Move.valid?(:wK, {:b, 2}, {:a, 1}) == true
    assert Move.valid?(:wK, {:b, 2}, {:b, 1}) == true
    assert Move.valid?(:wK, {:b, 2}, {:c, 1}) == true
    assert Move.valid?(:wK, {:b, 2}, {:a, 2}) == true
    assert Move.valid?(:wK, {:b, 2}, {:c, 2}) == true
    # Invalid moves
    assert Move.valid?(:wK, {:b, 2}, {:d, 2}) == false
    assert Move.valid?(:wK, {:b, 2}, {:b, 4}) == false
    assert Move.valid?(:wK, {:b, 2}, {:c, 4}) == false
    assert Move.valid?(:wK, {:b, 2}, {:a, 4}) == false
  end

  test "knight movements" do
    assert Move.valid?(:wN, {:c, 3}, {:b, 1}) == true
    assert Move.valid?(:wN, {:c, 3}, {:d, 1}) == true
    assert Move.valid?(:wN, {:c, 3}, {:b, 5}) == true
    assert Move.valid?(:wN, {:c, 3}, {:d, 5}) == true
    assert Move.valid?(:wN, {:c, 3}, {:e, 4}) == true
    assert Move.valid?(:wN, {:c, 3}, {:a, 4}) == true
    assert Move.valid?(:wN, {:c, 3}, {:e, 2}) == true
    assert Move.valid?(:wN, {:c, 3}, {:a, 2}) == true

    assert Move.valid?(:wN, {:c, 3}, {:a, 3}) == false
    assert Move.valid?(:wN, {:c, 3}, {:e, 3}) == false
    assert Move.valid?(:wN, {:c, 3}, {:a, 3}) == false
    assert Move.valid?(:wN, {:c, 3}, {:e, 3}) == false
    assert Move.valid?(:wN, {:c, 3}, {:a, 3}) == false
  end

  test "queen movements" do
    assert Move.valid?(:wQ, {:c, 3}, {:a, 1}) == true
    assert Move.valid?(:wQ, {:c, 3}, {:a, 5}) == true
    assert Move.valid?(:wQ, {:c, 3}, {:a, 3}) == true
    assert Move.valid?(:wQ, {:c, 3}, {:e, 1}) == true
    assert Move.valid?(:wQ, {:c, 3}, {:e, 5}) == true
    assert Move.valid?(:wQ, {:c, 3}, {:e, 3}) == true
    assert Move.valid?(:wQ, {:c, 3}, {:c, 1}) == true
    assert Move.valid?(:wQ, {:c, 3}, {:c, 5}) == true

    assert Move.valid?(:wQ, {:c, 3}, {:b, 1}) == false
    assert Move.valid?(:wQ, {:c, 3}, {:b, 5}) == false
    assert Move.valid?(:wQ, {:c, 3}, {:d, 1}) == false
    assert Move.valid?(:wQ, {:c, 3}, {:d, 5}) == false
  end
end
