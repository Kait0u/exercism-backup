# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %{plots: [], next_id: 1} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, & &1).plots
  end

  def register(pid, register_to) do
    %{plots: curr_plots, next_id: curr_next_id} = Agent.get_and_update(pid, & {&1, %{&1 | next_id: &1.next_id + 1}})

    new_plot = %Plot{plot_id: curr_next_id, registered_to: register_to}
    Agent.update(pid, & %{&1 | plots: [new_plot | curr_plots]})

    new_plot
  end

  def release(pid, plot_id) do
    new_plots = list_registrations(pid)
    |> Enum.reject(& &1.plot_id == plot_id)
    |> Enum.to_list()

    Agent.update(pid, & %{&1 | plots: new_plots})
  end

  def get_registration(pid, plot_id) do
    list_registrations(pid)
    |> Enum.find({:not_found, "plot is unregistered"}, & &1.plot_id == plot_id)
  end
end
