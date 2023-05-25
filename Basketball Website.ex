defmodule BasketballWebsite do
  defp get_information_from_path(data, paths) do
    [path | more_path] = paths
    if more_path == [] do
      data[path]
    else
      get_information_from_path(data[path], more_path)
    end
  end
  def extract_from_path(data, path) do
    # Please implement the extract_from_path/2 function
    get_information_from_path(data, String.split(path, "."))
  end

  def get_in_path(data, path) do
    # Please implement the get_in_path/2 function
    get_in(data, String.split(path, "."))
  end
end