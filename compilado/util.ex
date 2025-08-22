
defmodule Util do #Modulo Util
@moduledoc """
Modulo para mostrar funciones que piden info y muestran mensaje en elixir
"""

@doc """
Muestra un mensaje
"""
  def mostrar_mensaje(mensaje) do
    mensaje
    |> IO.puts()
  end

@doc """
Pide informacion
"""
  def pedir_informacion() do
    IO.gets("Ingrese su nombre: ")
    |> String.trim()
  end

end
