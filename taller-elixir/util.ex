
defmodule Util do


def input(message, type) when type == :string do
  message
  |> IO.gets()
  |> String.trim()
end

def input(message, type) when type == :integer do
  message
  |> input(:string)
  |> String.to_integer()
end

def input(message, type) when type == :float do
  message
  |> input(:string)
  |> String.to_float()
end

end
