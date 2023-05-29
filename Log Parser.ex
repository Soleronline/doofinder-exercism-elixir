defmodule LogParser do
  def valid_line?(line) do
    # Please implement the valid_line?/1 function
    String.match?(line, ~r/^\[(ERROR|DEBUG|INFO|WARNING)\](?:.*)$/)
  end

  def split_line(line) do
    # Please implement the split_line/1 function
    Regex.split(~r/\<[=|~|*|-]*\>/, line)
  end

  def remove_artifacts(line) do
    # Please implement the remove_artifacts/1 function
     to_string(Regex.split(~r/end-of-line[\d]+/i, line))
  end

  def tag_with_user_name(line) do
    # Please implement the tag_with_user_name/1 function
    # regex1 = ~r/^(\[\S*\]) (User)[\ |\\t]*([a-zA-Z!0-9]*)[\ |\\t]*((?:.*))/
    # regex1 = ~r/^(\[\S*\]) (User)[\ |\\t]([\ |\\t]*[a-zA-Z!0-9]*)[\ |\\t]*((?:.*))/
    regex1 = ~r/^(\[\S*\]) (User)( |\\t)([\ |\\t]*[a-zA-Z!0-9]*)[\ |\\t]*((?:.*))/
    regex2 = ~r/^(\[\S*\]) (\S*)[\ |\n]+(User)\W(\S*)((?:.*))/
    regex3 = ~r/^^(\[\S*\]) (User)[\ |\\t]*(\W*)[\ |\\t]*((?:.*))/
    regex4 = ~r/^(\[\S*\]) ((?:.*))(User)[\ |\\t]*(\S*)[\ |\\t]*((?:.*))/

    result = Regex.scan(regex1, line)
    if result != [] do
      [_, type, user, _, name, message] = result|>List.first
      "[#{user|>String.upcase}] #{name|>String.trim} #{type} #{user} #{name} #{message}"
    else
      result = Regex.scan(regex2, line)
      if result != [] do
        [_, _, _, user, name, _] = result|>List.first
        "[#{user|>String.upcase}] #{name} #{line}"
      else
        result = Regex.scan(regex3, line)
        if result != [] do
          [_, _, user, name, _] = result|>List.first
          "[#{user|>String.upcase}] #{name|>String.trim} #{line}"
        else
          result = Regex.scan(regex4, line)
          if result != [] do
            [_, _, _, user, name, _] = result|>List.first
            "[#{user|>String.upcase}] #{name|>String.trim} #{line}"
          else
            line
          end
        end
      end
    end
  end
end
