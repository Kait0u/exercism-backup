defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @planets [:mercury, :venus, :earth, :mars, :jupiter, :saturn, :uranus, :neptune]

  @earth_year_seconds 31_557_600

  @earth_relative_orbital_periods %{
    mercury:	0.2408467,
    venus:	  0.61519726,
    earth:    1.0,
    mars:	    1.8808158,
    jupiter:	11.862615,
    saturn:	  29.447498,
    uranus:	  84.016846,
    neptune:	164.79132
  }

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) when planet in @planets do
    earth_years = seconds / @earth_year_seconds
    planet_years = earth_years / @earth_relative_orbital_periods[planet]
    {:ok, planet_years}
  end

  def age_on(not_planet, _) when not_planet not in @planets do
    generate_error("not a planet")
  end

  @spec generate_error(message :: String.t()) :: {:error, String.t()}
  defp generate_error(message) do
    {:error, message}
  end
end
