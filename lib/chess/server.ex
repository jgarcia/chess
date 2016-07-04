defmodule Chess.Server do
  use GenServer
  alias Chess.Board

  def start do
    GenServer.start(Chess.Server, nil)
  end

  def join(pid, player) do
    GenServer.cast(pid, {:join, player})
  end

  def apply_move(pid, player, move) do
    GenServer.cast(pid, {:apply_move, player, move})
  end

  def get_board(pid) do
    GenServer.call(pid, {:get_board})
  end

  @doc """
  GenServer callbacks 
  """

  def init(_) do
    {:ok, Board.new_game(%{white: "player 1", black: "player 2"})}
  end

  def handle_cast({:apply_move, player, move}, state) do
    case Board.apply_move(state, player, move) do
      {:error, _} -> {:noreply, state}
      new_state   -> {:noreply, new_state}
    end
  end
  
  def handle_call({:get_board}, _, state) do
    {:reply, state, state}
  end
end
