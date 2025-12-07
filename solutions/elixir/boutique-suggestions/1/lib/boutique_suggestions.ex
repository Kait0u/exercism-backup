defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    maximum_price = Keyword.get(options, :maximum_price, 100.0)

    combinations = for t <- tops, b <- bottoms, t.base_color != b.base_color do
      {t, b}
    end
    combinations = for c = {t, b} <- combinations, t.price + b.price <= maximum_price, do: c

    combinations
  end
end
