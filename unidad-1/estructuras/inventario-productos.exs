defmodule Main do
  @moduledoc """
  Módulo que simula un inventario de productos
  """

def main do

  productos = crear_lista_productos()
  aumentar_precios(productos)
  filtrar_por_stock(productos)

end

@doc """
Añade productos a la lista, los muestra y los retorna
"""
def crear_lista_productos do
  productos = [
    %{nombre: "Arroz", precio: 2500, stock: 10},
    %{nombre: "Panela", precio: 4200, stock: 8},
    %{nombre: "Sal", precio: 1200, stock: 3}
  ]
  Util.show_message("Productos disponibles: #{inspect(productos)}")
  productos #retornar los productos
end

@doc """
Aumenta un 10% el precios de los productos existentes
"""
def aumentar_precios(productos) do
  con_aumento = Enum.map(productos, fn x -> %{x | precio: x.precio * 1.10}  end)
  Util.show_message("Productos con aumento de 10% en precios: #{inspect(con_aumento)}")
end

@doc """
Filtra los productos por cantidad de stock mayor a 5
"""
def filtrar_por_stock(productos) do
  filtrados = Enum.group_by(productos, fn producto -> producto.stock > 5 end )
  Util.show_message("Productos con stock mayor a 5 #{inspect(filtrados)}")
end

end

Main.main()
