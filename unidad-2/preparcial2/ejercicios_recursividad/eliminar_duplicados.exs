defmodule Main do

  def main do

    lista1 = [1, 2, 3, 2, 4, 3, 5]
    IO.puts("Lista original: #{inspect(lista1)}")
    IO.puts("Sin duplicados: #{inspect(eliminar_duplicados(lista1))}")

    lista2 = ["a", "b", "a", "c", "b", "d"]
    IO.puts("Lista original: #{inspect(lista2)}")
    IO.puts("Sin duplicados: #{inspect(eliminar_duplicados(lista2))}")

    lista3 = [1, 1, 1, 1]
    IO.puts("Lista original: #{inspect(lista3)}")
    IO.puts("Sin duplicados: #{inspect(eliminar_duplicados(lista3))}")

    lista4 = []
    IO.puts("Lista vacía: #{inspect(lista4)}")
    IO.puts("Sin duplicados: #{inspect(eliminar_duplicados(lista4))}")

  end

   @doc """
  Elimina elementos duplicados de una lista, conservando el primer orden de aparición.
  """
  def eliminar_duplicados(lista) do
    eliminar_duplicados_aux(lista, [])
  end

  # Función auxiliar que mantiene una lista de elementos ya vistos
  defp eliminar_duplicados_aux([], _vistos), do: []

  defp eliminar_duplicados_aux([head | tail], vistos) do
    if esta_en_lista?(head, vistos) do
      # Si ya está en vistos, lo omitimos
      eliminar_duplicados_aux(tail, vistos)
    else
      # Si no está, lo agregamos al resultado y a vistos
      [head | eliminar_duplicados_aux(tail, [head | vistos])]
    end
  end

  # Función auxiliar para verificar si un elemento está en la lista
  defp esta_en_lista?(_elemento, []), do: false

  defp esta_en_lista?(elemento, [head | tail]) do
    if elemento == head do
      true
    else
      esta_en_lista?(elemento, tail)
    end

  end

end

Main.main()
