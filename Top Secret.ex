defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({op, _, args} = ast, acc) when op in [:def, :defp] do
    IO.inspect(args)
    {name, len} = case args do
      [{:when, _, [{name, _, args} | _]} | _] -> {name, length(args)}
      [{name, _, nil} | _] -> {name, 0}
      [{name, _, args} | _] -> {name, length(args)}
    end
    name = String.slice(name|>Atom.to_string, 0, len)
    {ast, [name | acc]}
  end
  def decode_secret_message_part(ast, acc) do
    # Please implement the decode_secret_message_part/2 function
    {ast, acc}
  end

  def decode_secret_message(string) do
    # Please implement the decode_secret_message/1 function
    {_ast, message} =
      string
      |> to_ast()
      |> Macro.prewalk([], &decode_secret_message_part/2)

    message
    |> Enum.reverse()
    |> Enum.join()
  end
end
