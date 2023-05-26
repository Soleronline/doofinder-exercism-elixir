# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    # Please implement the start/1 function
    Agent.start_link(fn -> %{last_id: 0, plots: opts} end)
  end

  def list_registrations(pid) do
    # Please implement the list_registrations/1 function
    Agent.get(pid, fn state -> state.plots end)
  end

  def register(pid, register_to) do
    # Please implement the register/2 function
    new_id = Agent.get(pid, fn state -> state.last_id end) + 1
    reg = %Plot{plot_id: new_id, registered_to: register_to}
    Agent.update(pid, fn state ->
      %{state| last_id: new_id, plots: state.plots ++ [reg]}
    end)
    reg
  end

  def release(pid, plot_id) do
    # Please implement the release/2 function
    Agent.update(pid, fn state ->
      %{state | plots: Enum.reject(state.plots, fn plot -> plot.plot_id == plot_id end)}
    end)
  end

  def get_registration(pid, plot_id) do
    # Please implement the get_registration/2 function
    reg = Agent.get(pid, fn state ->
      Enum.filter(state.plots, fn plot -> plot.plot_id == plot_id end)
    end)

    if reg == [] do
      {:not_found, "plot is unregistered"}
    else
      hd(reg)
    end
  end
end
