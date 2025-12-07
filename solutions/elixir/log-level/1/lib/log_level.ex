defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      level == 0 -> cond do
        legacy? -> :unknown
        true -> :trace
      end
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 -> cond do
        legacy? -> :unknown
        true -> :fatal
      end
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)
    cond do
      label == :unknown -> cond do
          legacy? -> :dev1
          true -> :dev2
      end
      label in [:error, :fatal] -> :ops
      true -> false
    end
  end
end
