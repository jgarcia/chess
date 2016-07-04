defmodule Chess.Board do
  alias Chess.Board
  alias Chess.Move

  defstruct white: "player 1",
    black: "player 2",
    moves: [],
    pieces_captured_by_white: [],
    pieces_captured_by_black: [],
    matrix: %{
      a: [:wR, :wP, 0, 0, 0, 0, :bP, :bR],
      b: [:wN, :wP, 0, 0, 0, 0, :bP, :bN],
      c: [:wB, :wP, 0, 0, 0, 0, :bP, :bB],
      d: [:wQ, :wP, 0, 0, 0, 0, :bP, :bQ],
      e: [:wK, :wP, 0, 0, 0, 0, :bP, :bK],
      f: [:wB, :wP, 0, 0, 0, 0, :bP, :bB],
      g: [:wN, :wP, 0, 0, 0, 0, :bP, :bN],
      h: [:wR, :wP, 0, 0, 0, 0, :bP, :bR],
    }

  def new_game %{white: player_1, black: player_2} do
    %Board{white: player_1, black: player_2}
  end

  def apply_move(board, player, {piece, origin, destination}) do
    cond do
      player == Board.last_player_to_move(board) ->
        {:error, "Cannot perform two moves in a row"}
      Board.player_can_move_piece?(board, player, piece) == false ->
        {:error, "Cannot move other player's pieces"}
      Move.valid?(piece, origin, destination) == false ->
        {:error, "Invalid Move"}
      true ->
        board
        |> remove_piece_at(piece, origin)
        |> put_piece_at(piece, destination)
        |> record_move(player, piece, destination)
    end
  end

  def player_can_move_piece?(board, player, piece) do
    cond do
      board.white == player ->
        Atom.to_string(piece)
        |> String.starts_with?("w")
      board.black == player ->
        Atom.to_string(piece)
        |> String.starts_with?("b")
      true ->
        false
    end
  end

  def record_move(board, player, piece, {x, y}) do
    move = {player, "#{piece}#{x}#{y}"}
    moves = Enum.reverse([ move |
                           Enum.reverse(board.moves)])

    %{board | moves: moves}
  end

  def last_player_to_move board do
    case List.last(board.moves) do
      {player, _} -> player
      _ -> nil
    end
  end

  def remove_piece_at board, piece, position do
    if Board.piece_at(board, position) == piece do
      Board.set_value_at(board, 0, position)
    else
      board
    end
  end

  def put_piece_at board, piece, position do
    set_value_at(board, piece, position)
  end

  def set_value_at board, value, {x, y} do
    updated_column = board.matrix[x]
    |> List.replace_at(y-1, value)

    new_matrix = Map.put board.matrix, x, updated_column
    %{ board | matrix: new_matrix }
  end

  def piece_at board, position do
    {x, y} = position
    board.matrix[x]
    |> Enum.at(y-1)
  end
end
