defmodule TakeANumber do
  def start() do
    spawn(&process_loop/0)
  end

  defp process_loop(state \\ 0) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, state)
        process_loop(state)
      {:take_a_number, sender_pid} ->
        new_number = state + 1
        send(sender_pid, new_number)
        process_loop(new_number)
      :stop -> :ok
      _ -> process_loop(state)
    end
  end
end
