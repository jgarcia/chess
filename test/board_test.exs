defmodule BoardTest do
  use ExUnit.Case
  alias Chess.Board

  test "every player move updates the state of the board" do
    board = Board.new_game(%{white: 'Jon', black: 'Stewart'})
    |> Board.apply_move('Jon', {:wP, {:c, 2}, {:c, 3}})
    assert Board.piece_at(board, {:c, 3}) == :wP
    assert board.white == 'Jon'
    assert board.black == 'Stewart'
  end

  test "every player move is recorded in the move list" do
    board = Board.new_game(%{white: 'Jon', black: 'Stewart'})
    |> Board.apply_move('Jon', {:wP, {:c, 2}, {:c, 3}})
    assert Enum.empty?(board.moves) == false
  end

  test "a player cannot perform two moves in a row" do
    result = Board.new_game(%{white: 'Jon', black: 'Stewart'})
    |> Board.apply_move('Jon', {:wP, {:c, 2}, {:c, 3}})
    |> Board.apply_move('Jon', {:wP, {:d, 2}, {:d, 3}})
    assert result == {:error, "Cannot perform two moves in a row"}
  end

  test "a player can only perform valid moves" do
    result = Board.new_game(%{white: 'Jon', black: 'Stewart'})
    |> Board.apply_move('Jon', {:wP, {:c, 2}, {:c, 8}})
    assert result == {:error, "Invalid Move"}
  end

  test "a player cannot move the other players pieces" do
    result = Board.new_game(%{white: 'Jon', black: 'Stewart'})
    |> Board.apply_move('Jon', {:bP, {:c, 7}, {:c, 6}})
    assert result == {:error, "Cannot move other player's pieces"}
  end
end
