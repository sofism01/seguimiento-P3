defmodule Main do
@moduledoc """
Módulo para contar elementos en una lista de forma recursiva.
"""

@doc """
Función principal que ejecuta el conteo de elementos en una lista de ejemplo.
"""
  def main do
    lista = [1, 2, 3, 4, 5]
    cantidad = contar_elementos(lista)
    IO.puts("La lista tiene #{cantidad} elementos.")
  end

  @doc """
  Cuenta el número de elementos en una lista de forma recursiva.
  """
  def contar_elementos([]), do: 0 #caso base

  def contar_elementos([_ | resto]), do: 1 + contar_elementos(resto) #llamado recursivo

end

Main.main()
