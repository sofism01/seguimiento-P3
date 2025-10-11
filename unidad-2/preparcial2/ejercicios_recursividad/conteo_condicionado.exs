defmodule Main do

  def main do

    lista = [3, 5, 7, 9, 10, 11, 15, 20]
    resultado = contar_multiplos(lista)
    IO.puts("Números múltiplos de 3 o 5: #{resultado}")

    # Casos edge
    IO.puts("Lista vacía: #{contar_multiplos([])}")
    IO.puts("Un elemento múltiplo: #{contar_multiplos([15])}")
    IO.puts("Un elemento no múltiplo: #{contar_multiplos([7])}")

  end

  @doc """
  Cuenta cuántos números en la lista son múltiplos de 3 o de 5.
  """
  # Caso base: lista vacía
  def contar_multiplos([]), do: 0

  # Caso: lista con un elemento
  def contar_multiplos([head]) do
    if es_multiplo_3_o_5?(head), do: 1, else: 0
  end

  # Caso recursivo: lista con más de un elemento
  def contar_multiplos([head | tail]) do
    contador = if es_multiplo_3_o_5?(head), do: 1, else: 0
    contador + contar_multiplos(tail)
  end

  defp es_multiplo_3_o_5?(numero) do
    rem(numero, 3) == 0 or rem(numero, 5) == 0
  end

end

Main.main()
