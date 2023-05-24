defmodule Username do
  defp clean_username([]), do: []
  defp clean_username([character | characters]) do
    new_char = case character do
      character when character == ?ä -> [?a, ?e]
      character when character == ?ö -> [?o, ?e]
      character when character == ?ü -> [?u, ?e]
      character when character == ?ß -> [?s, ?s]
      character when (character < ?a or character > ?z) and character != ?_ -> nil
      _ -> [character]
    end
    if new_char == nil do
      clean_username(characters)
    else
      new_char ++ clean_username(characters)
    end
  end
  def sanitize(username) do
    # ä becomes ae
    # ö becomes oe
    # ü becomes ue
    # ß becomes ss

    # Please implement the sanitize/1 function
    clean_username(username)
  end
end