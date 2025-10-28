defmodule Problema do #Modulo -> UpperCamelCase
@moduledoc """
Módulo para demostrar el uso de funciones privadas en Elixir.
"""

defp mostrar_mensaje_privado(mensaje) do
  mensaje
  |> IO.puts()
end

@doc """
Invoca la función privada para mostrar un mensaje.
"""
def invocacion_privado() do
  "Bienvenidos a la empresa Once Ltda"
  |> mostrar_mensaje_privado()
end
end

Problema.invocacion_privado()
