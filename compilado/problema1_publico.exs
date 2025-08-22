defmodule Problema do #Modulo -> UpperCamelCase
@moduledoc """
Modulo para mostrar funciones publicas en elixir
"""
@doc """
Funcion publica que muestra un mensaje de bienvenida.
"""
def mostrar_mensaje() do
  "Bienvenidos a la empresa Once Ltda"
  |> IO.puts()
end

end

Problema.mostrar_mensaje()
