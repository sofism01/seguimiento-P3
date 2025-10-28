
defmodule Util2 do
  @moduledoc """
  Módulo para interactuar con Java y mostrar mensajes.
  """

  @doc """
    Muestra un mensaje usando java.
  """
def show_message(message) do
  System.cmd("java", ["-cp", ".", "Mensaje", message])
end

@doc """
  Pide información usando java y devuelve la respuesta.
  """
def input_data(message) do
  System.cmd("java", ["-cp", ".", "Mensaje", "input", message])
  |> elem(0)
  |> String.trim()
end
end
