defmodule Main do
  @moduledoc """
  Módulo para generar todas las permutaciones de una lista de forma recursiva.
  """
  @doc """
  Función principal que ejecuta la generación de permutaciones para una lista de ejemplo.
  """
  def main do
    lista = [1, 2, 3]
    IO.inspect(permutaciones(lista))
  end

  @doc """
  Genera todas las permutaciones de una lista de forma recursiva.
  """
  def permutaciones([]), do: [[]]   # Caso base

  def permutaciones(lista) do
    for elem <- lista, perm <- permutaciones(lista -- [elem]) do   # Caso recursivo
      [elem | perm]
    end
  end

end

Main.main()
