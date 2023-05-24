defmodule TakeANumber do
  def start() do
    # Please implement the start/0 function
    {_, pid} = Task.start_link(fn -> loop(0) end)
    pid
  end
  def loop(state) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, state)
        loop(state)
      {:take_a_number, sender_pid} ->
        state = state + 1
        send(sender_pid, state)
        loop(state)
      :stop ->
        nil
      _ ->
        loop(state)
    end
    
  end
end