defmodule ServerTest do
  use ExUnit.Case
  alias Chess.Server

  test "starting a new server" do
    assert {:ok, _} = Server.start
  end

  test "can get the current state of the board" do
    {:ok, server} = Server.start

    board = Server.get_board(server)
    assert board != nil
  end

  test "can join a server" do
    {:ok, server} = Server.start
    Server.join(server, "jon")
    board = Server.get_board(server)
    assert board.white == "jon"
  end
end
