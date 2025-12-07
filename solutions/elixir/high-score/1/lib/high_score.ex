defmodule HighScore do
  def new(), do: %{}

  def add_player(scores, name, score \\ 0) do
    Map.put(scores, name, score)
  end

  def remove_player(scores, name) do
    Map.delete(scores, name)
  end

  def reset_score(scores, name) do
    Map.put(scores, name, 0)
  end

  def update_score(scores, name, score) do
    elem(
      Map.get_and_update(
        scores,
        name,
        fn curr_val ->
          {
            curr_val,
            cond do
              curr_val == nil -> 0
              true -> curr_val
            end + score
          }
        end
      ),
      1
    )
  end

  def get_players(scores) do
    Map.keys(scores)
  end
end
