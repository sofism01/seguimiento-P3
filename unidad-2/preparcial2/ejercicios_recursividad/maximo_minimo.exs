defmodule Main do

def main do

 lista1 = [3, 1, 4, 1, 5, 9, 2, 6]
    IO.puts("Lista: #{inspect(lista1)}")
    IO.puts("Min-Max: #{inspect(min_max(lista1))}")

    lista2 = [42]
    IO.puts("Lista con un elemento: #{inspect(lista2)}")
    IO.puts("Min-Max: #{inspect(min_max(lista2))}")

    lista3 = []
    IO.puts("Lista vacía: #{inspect(lista3)}")
    IO.puts("Min-Max: #{inspect(min_max(lista3))}")

    lista4 = [-5, -1, -10, -3]
    IO.puts("Lista con negativos: #{inspect(lista4)}")
    IO.puts("Min-Max: #{inspect(min_max(lista4))}")

end

@doc """
  Encuentra el mínimo y máximo de una lista de enteros.
  Retorna una tupla {min, max} o {:error, :lista_vacia} si la lista está vacía.
  """
  # Caso base: lista vacía
  def min_max([]), do: {:error, :lista_vacia}

  # Caso: lista con un solo elemento
  def min_max([elemento]), do: {elemento, elemento}

  # Caso recursivo: lista con más de un elemento
  def min_max([head | tail]) do
    {min_tail, max_tail} = min_max(tail)
    {min(head, min_tail), max(head, max_tail)}
  end

end

Main.main()
