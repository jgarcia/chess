defmodule CacheTest do
  use ExUnit.Case
  alias Chess.Cache

  test "fetching existing server should not create a new server" do
    Chess.Supervisor.start_link
    {:ok, server} = Cache.get_server("jon's board")
    {:ok, server_2} = Cache.get_server("jon's board")

    assert server == server_2
  end

  test "servers are unique, one server per name" do
    Chess.Supervisor.start_link
    {:ok, server} = Cache.get_server("jon's board")
    {:ok, server_2} = Cache.get_server("james' board")

    assert server != server_2
  end
end
