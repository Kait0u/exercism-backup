defmodule KitchenCalculator do
  @cup_ml 240
  @fluid_ounce_ml 30
  @teaspoon_ml 5
  @tablespoon_ml 15

  def get_volume(volume_pair) do
    {_unit, value} = volume_pair
    value
  end

  def to_milliliter({:milliliter = _unit, value}), do: {:milliliter, value}

  def to_milliliter({:cup = _unit, value}), do: {:milliliter, value * @cup_ml}

  def to_milliliter({:fluid_ounce = _unit, value}), do: {:milliliter, value * @fluid_ounce_ml}

  def to_milliliter({:teaspoon = _unit, value}), do: {:milliliter, value * @teaspoon_ml}

  def to_milliliter({:tablespoon = _unit, value}), do: {:milliliter, value * @tablespoon_ml}


  def from_milliliter({:milliliter = _unit, _value} = volume_pair, :milliliter = _target_unit), do: volume_pair

  def from_milliliter({:milliliter = _unit, value} = _volume_pair, :cup = target_unit), do: {target_unit, value / @cup_ml}

  def from_milliliter({:milliliter = _unit, value} = _volume_pair, :fluid_ounce = target_unit), do: {target_unit, value / @fluid_ounce_ml}

  def from_milliliter({:milliliter = _unit, value} = _volume_pair, :tablespoon = target_unit), do: {target_unit, value / @tablespoon_ml}

  def from_milliliter({:milliliter = _unit, value} = _volume_pair, :teaspoon = target_unit), do: {target_unit, value / @teaspoon_ml}


  def convert({_source_unit, _source_value} = volume_pair, target_unit) do
    middle_vp = to_milliliter(volume_pair)
    from_milliliter(middle_vp, target_unit)
  end
end
