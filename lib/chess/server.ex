defmodule Chess.Server do
  use GenServer
  alias Chess.Board

  def start do
    GenServer.start(Chess.Server, {"Jon", "Jim"})
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

  def init({player_1, player_2}) do
    {:ok, Board.new_game(%{white: player_1, black: player_2})}
  end

  def handle_cast({:apply_move, player, move}, state) do
    case Board.apply_move(state, player, move) do
      {:error, _} -> {:noreply, state}
      board       -> {:noreply, board}
    end
  end
  
  def handle_call({:get_board}, _, state) do
    {:reply, state, state}
  end
end
