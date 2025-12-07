defmodule Chessboard do
  @min_rank 1
  @max_rank 8

  @min_file_rank ?A
  @max_file_rank ?H

  def rank_range do
    @min_rank .. @max_rank
  end

  def file_range do
    @min_file_rank .. @max_file_rank
  end

  def ranks do
    rank_range()
    |> Enum.to_list()
  end

  def files do
    file_range()
    |> Enum.map(&(List.to_string([&1])))
    |> Enum.to_list()
  end
end
