defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    already_owned = MapSet.member?(collection, card)
    {already_owned, MapSet.put(collection, card)}
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    {
      !(MapSet.member?(collection, their_card) or not MapSet.member?(collection, your_card)),
      collection
      |> MapSet.delete(your_card)
      |> MapSet.put(their_card)
    }
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    MapSet.new(cards)
    |> MapSet.to_list()
    |> Enum.sort()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    MapSet.difference(your_collection, their_collection)
    |> MapSet.size()
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards([]), do: []

  def boring_cards(collections) do
    collections
    |> Enum.reduce(&MapSet.intersection/2)
    |> MapSet.to_list()
    |> Enum.sort()
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards([]), do: 0

  def total_cards(collections) do
    collections
    |> Enum.reduce(fn acc, collection -> MapSet.union(acc, collection) end)
    |> MapSet.new()
    |> MapSet.size()
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    shinies =
      collection
      |> Enum.filter(fn c -> String.starts_with?(c, "Shiny") end)
      |> MapSet.new()

    {
      MapSet.to_list(shinies)
      |> Enum.sort(),
      MapSet.difference(collection, shinies)
      |>MapSet.to_list()
      |> Enum.sort()
    }
  end
end
