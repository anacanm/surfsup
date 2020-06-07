defmodule BuoyCollection.BuoyData do
  defstruct year: nil,
            month: nil,
            day: nil,
            hour: nil,
            minute: nil,
            wave_height: nil,
            swell_height: nil,
            swell_period: nil,
            wind_wave_height: nil,
            wind_wave_period: nil,
            swell_direction: nil,
            wind_wave_direction: nil,
            steepness: nil,
            average_wave_period: nil,
            mean_wave_direction: nil
end
