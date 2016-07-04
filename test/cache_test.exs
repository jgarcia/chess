defmodule CacheTest do
  use ExUnit.Case
  alias Chess.Cache
  alias Chess.Server

  test "fetching board that does not exist returns a new board" do
    {:ok, cache} = Cache.start
    {:ok, server} = Cache.get_server(cache, "jon's board")
    board = Server.get_board(server)
    assert board.white ==  "player 1"
  end

  test "fetching existing server should not create a new server" do
    {:ok, cache} = Cache.start
    {:ok, server} = Cache.get_server(cache, "jon's board")
    {:ok, server_2} = Cache.get_server(cache, "jon's board")

    assert server == server_2
  end

  test "servers are unique, one server per name" do
    {:ok, cache} = Cache.start
    {:ok, server} = Cache.get_server(cache, "jon's board")
    {:ok, server_2} = Cache.get_server(cache, "james' board")

    assert server != server_2
  end
end
