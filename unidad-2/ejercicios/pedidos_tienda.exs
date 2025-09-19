defmodule Main do
  @moduledoc """
  Módulo para calcular la cantidad total de productos pedidos en una lista de pedidos.
  """
  @doc """
  Función principal que ejecuta el cálculo de la cantidad total de productos en una lista de pedidos de ejemplo.
  """
  def main do
    pedidos = [
      %{producto: "Pan", cantidad: 3},
      %{producto: "Leche", cantidad: 2},
      %{producto: "Queso", cantidad: 5}
    ]
    IO.puts("Cantidad total de productos pedidos: #{total_cantidad(pedidos)}")
  end

  @doc """
  Calcula la cantidad total de productos en una lista de pedidos.
  """
  def total_cantidad([]), do: 0 # Caso base: lista vacía

  def total_cantidad([%{cantidad: cantidad} | tail]), do: cantidad + total_cantidad(tail)  # Caso recursivo


end

Main.main()
