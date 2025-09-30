defmodule Main do
  @moduledoc """
  Módulo para buscar un elemento en una lista de forma recursiva.
  """

  @doc """
  Función principal que ejecuta la búsqueda de un elemento en una lista de ejemplo.
  """
   def main do
    lista = [1, 2, 3, 4]
    IO.puts(existe?(3, lista))  
    IO.puts(existe?(5, lista))
  end

  @doc """
  Busca un elemento en una lista de forma recursiva.
  """
  def existe?(_, []), do: false # Caso base: lista vacía
  def existe?(elemento, [elemento | _]), do: true # Caso base: elemento encontrado
  def existe?(elemento, [_ | tail]), do: existe?(elemento, tail) # Llamada recursiva

end

Main.main()
