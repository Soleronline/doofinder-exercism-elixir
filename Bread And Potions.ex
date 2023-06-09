defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  # Add code to define the protocol and its implementations below here...
  defprotocol Edible do
    def eat(item, character)
  end
  
  defimpl Edible, for: [RPG.LoafOfBread, RPG.Character] do
    def eat(_, character) do
      # [nil, character]
      {nil, %{character | health: character.health + 5}}
    end
  end
  
  defimpl Edible, for: [RPG.ManaPotion, RPG.Character] do
    def eat(potion, character) do
      {%RPG.EmptyBottle{}, %{character | mana: character.mana + potion.strength}}
    end
  end
  
  defimpl Edible, for: [RPG.Poison, RPG.Character] do
    def eat(_, character) do
      {%RPG.EmptyBottle{}, %{character | health: 0}}
    end
  end

end
