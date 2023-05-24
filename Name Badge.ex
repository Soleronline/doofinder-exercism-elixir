defmodule NameBadge do
  def print(id, name, department) do
    # Please implement the print/3 function
    
    my_department = if is_nil(department),  do: "OWNER", else: department|>String.upcase()
    if is_nil(id), do: "#{name} - #{my_department}", else: "[#{id}] - #{name} - #{my_department}"
  end
end