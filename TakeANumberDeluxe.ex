defmodule TakeANumberDeluxe do
  # Client API
  use GenServer

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
  # Please implement the start_link/1 function
      if is_number(init_arg[:min_number]) &&
          is_number(init_arg[:max_number]) &&
          init_arg[:min_number] < init_arg[:max_number]
      do
        auto_shutdown_timeout = if Keyword.has_key?(init_arg, :auto_shutdown_timeout), do: init_arg[:auto_shutdown_timeout], else: :infinity

        case TakeANumberDeluxe.State.new(init_arg[:min_number], init_arg[:max_number], auto_shutdown_timeout) do
          {:ok, state} ->
            GenServer.start_link(__MODULE__, state, timeout: auto_shutdown_timeout)
          {:error, error} ->
            {:error, error}
        end
      else
        {:error, :invalid_configuration}
      end
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    # Please implement the report_state/1 function
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    # Please implement the queue_new_number/1 function
    GenServer.call(machine, :queue_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    # Please implement the serve_next_queued_number/2 function
    GenServer.call(machine, {:serve_next_queued_number , priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset_state)
  end

  # Server callbacks

  # Please implement the necessary callbacks

  @impl true
  def init(state) do
    {:ok, state, state.auto_shutdown_timeout}
  end

  @impl true
  def handle_call(:report_state, _, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl true
  def handle_call(:queue_new_number, _, state) do
    case TakeANumberDeluxe.State.queue_new_number(state) do
      {:ok, new_number, new_state} ->
        {:reply, {:ok, new_number}, new_state, state.auto_shutdown_timeout}
      {:error, error} ->
        {:reply, {:error, error}, state, state.auto_shutdown_timeout}
    end
  end

  @impl true
  def handle_call({:serve_next_queued_number , priority_number}, _, state) do
    case TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number) do
      {:ok, new_number, new_state} ->
        {:reply, {:ok, new_number}, new_state, state.auto_shutdown_timeout}
      {:error, error} ->
        {:reply, {:error, error}, state, state.auto_shutdown_timeout}
    end
  end

  @impl true
  def handle_cast(:reset_state, state) do
    {:ok, new_state} = TakeANumberDeluxe.State.new(state.min_number, state.max_number, state.auto_shutdown_timeout)
    {:noreply, new_state, new_state.auto_shutdown_timeout}
  end

  @impl true
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  @impl true
  def handle_info(_, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end
