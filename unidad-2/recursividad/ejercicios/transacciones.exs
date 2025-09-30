defmodule Main do
@moduledoc """
Módulo para calcular el balance final a partir de una lista de transacciones.
"""

@doc """
Función principal que ejecuta el cálculo del balance final en una lista de ejemplo.
"""
def main do
  transacciones = [1000, -200, 500, -100, -50]
  IO.puts("Balance final: #{balance_final(transacciones)}")
end

  @doc """
  Calcula el balance final a partir de una lista de transacciones.
  """
  def balance_final([]), do: 0 # Caso base: lista vacía

  def balance_final([head | tail]), do: head + balance_final(tail) # Caso recursivo


end

Main.main()
