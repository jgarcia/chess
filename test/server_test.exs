defmodule ServerTest do
  use ExUnit.Case
  alias Chess.Server

  test "starting a new server" do
    assert {:ok, _} = Server.start
  end

  test "can get the current state of the board" do
    {:ok, server} = Server.start

    board = Server.get_board(server)
    assert board.white == "player 1"
  end
end
