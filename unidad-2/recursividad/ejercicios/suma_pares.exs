defmodule Main do
  @moduledoc """
  Módulo para sumar los números pares en una lista de forma recursiva.
  """
  @doc """
  Función principal que ejecuta la suma de números pares en una lista de ejemplo.
  """
   def main do
    lista = [1, 2, 3, 4, 5, 6]
    IO.puts("Suma de pares: #{suma_pares(lista)}")  
  end

  @doc """
  Suma los números pares en una lista de forma recursiva.
  """
  def suma_pares([]), do: 0  # Caso base: lista vacía

  def suma_pares([head | tail]) when rem(head, 2) == 0, do: head + suma_pares(tail)  # Caso recursivo: si el head es par, lo suma

  def suma_pares([_head | tail]), do: suma_pares(tail) # Caso recursivo: si el head es impar, lo ignora

end

Main.main()
