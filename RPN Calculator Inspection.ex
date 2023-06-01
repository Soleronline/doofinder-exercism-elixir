defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    # Please implement the start_reliability_check/2 function
    {_, pid} = Task.start_link(fn -> calculator.(input) end)
    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    # Please implement the await_reliability_check_result/2 function
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _reason} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    # Please implement the reliability_check/2 function
    old_flag = Process.flag(:trap_exit, true)
    pid_results =  Enum.map(
        inputs, fn input -> start_reliability_check(calculator, input)
      end)
      |> Enum.map(
        fn data -> await_reliability_check_result(data, %{})
      end)
    Process.flag(:trap_exit, old_flag)
    List.foldl(pid_results, %{}, fn map, acc -> Map.merge(acc, map) end)
  end

  def correctness_check(calculator, inputs) do
    # Please implement the correctness_check/2 function
    inputs
	  |> Enum.map(fn params -> Task.async(fn -> calculator.(params) end) end)
	  |> Enum.map(fn task -> Task.await(task, 100) end)
  end
end
