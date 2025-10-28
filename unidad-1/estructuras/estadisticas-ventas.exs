defmodule Main do
  @moduledoc """
  Modulo para las estadisticas de una tienda de ropa
  """

  def main do

    ventas = definir_ventas()
    suma_total(ventas)
    agrupar_por_producto(ventas)
    convertir_mapa(ventas)
    producto_mas_vendido(ventas)

  end

  @doc """
  Función para declarar las ventas
  """
  def definir_ventas do
    ventas = [
      %{producto: "Falda", monto: 30000, ventas: 10},
      %{producto: "Camisa", monto: 50000, ventas: 12},
      %{producto: "Top", monto: 25000, ventas: 7},
      %{producto: "Jean", monto: 75000, ventas: 15}
    ]
    Util.show_message("Las ventas de la tienda: #{inspect(ventas)}")
    ventas
  end

  @doc """
  Función para calcular el total vendido
  """
  def suma_total(ventas) do
    total_ventas = Enum.reduce(ventas, 0, fn venta, acc -> acc + venta.monto end)
    Util.show_message("El total de las ventas es: #{inspect(total_ventas)}")
  end

  @doc """
  Función para agrupar ventas por producto
  """
  def agrupar_por_producto(ventas) do
    filtro =Enum.group_by(ventas, fn ventas -> ventas.producto end)
    Util.show_message("Ventas agrupadas por producto: #{inspect(filtro)}")
  end

  @doc """
  Función para convertir a tuplas
  """
  def convertir_mapa(ventas) do
   agrupado = Enum.group_by(ventas, fn venta -> venta.producto end)
   lista_tuplas = Map.to_list(agrupado)
   Util.show_message("Mapa convertido a lista de tuplas: #{inspect(lista_tuplas)}")
  end

  @doc """
  Función para encontrar el producto con más cantidad deventas
  """
  def producto_mas_vendido(ventas) do
    producto = Enum.max_by(ventas, fn venta -> venta.ventas end)
    Util.show_message("El producto más vendido es: #{inspect(producto)}")
  end

end

Main.main()
