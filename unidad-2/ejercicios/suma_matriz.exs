defmodule Main do
  @moduledoc """
  Módulo para sumar todos los elementos de una matriz (lista de listas) de forma recursiva.
  """
  @doc """
  Función principal que ejecuta la suma de una matriz de ejemplo.
  """
  def main do
    matriz = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]
    IO.puts("Suma de la matriz: #{suma_matriz(matriz)}")  
  end

  @doc """
  Suma todos los elementos de una matriz (lista de listas) de forma recursiva.
  """
  def suma_fila([]), do: 0 # Caso base: fila vacía
  def suma_fila([head | tail]), do: head + suma_fila(tail) # Llamada recursiva

  def suma_matriz([]), do: 0 # Caso base: matriz vacía
  def suma_matriz([fila | resto]), do: suma_fila(fila) + suma_matriz(resto) # Llamada recursiva

end

Main.main()
