defmodule Chess.Cache do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: :chess_cache)
  end

  def get_server(name) do
    GenServer.call(:chess_cache, {:get_board, name})
  end

  @doc  """
  GenServer callbacks
  """

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:get_board, name}, _, state) do
    if state[name] == nil do
      server = Chess.Server.start
      new_state = Map.put(state, name, server)
      {:reply, server, new_state}
    else
      {:reply, state[name], state}
    end
  end
end
