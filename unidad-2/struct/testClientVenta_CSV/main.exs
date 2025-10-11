defmodule Main do
@moduledoc """
Módulo principal para ejecutar la lógica de ventas.
"""
@doc """
Función principal que crea clientes, productos, detalles y ventas, y calcula el total de la venta.
"""
def main do

  c1 = Cliente.crear("Juan Perez", "1234567890")
  c2 = Cliente.crear("Maria Gomez", "0987654321")
  c3 = Cliente.crear("Carlos Ruiz", "1122334455")
  Cliente.escribir_csv([c1, c2, c3], "clientes.csv")

  listado_clientes = Cliente.leer_csv("clientes.csv")
  IO.inspect(listado_clientes)

  p1 = Producto.crear("Laptop", 800.0)
  p2 = Producto.crear("Mouse", 25.0)
  p3 = Producto.crear("Teclado", 45.0)

  d1 = Detalle.crear(p1, 1)
  d2 = Detalle.crear(p2, 2)
  d3 = Detalle.crear(p3, 1)
  Detalle.escribir_csv([d1, d2, d3], "detalles.csv")

  listado_detalles = Detalle.leer_csv("detalles.csv")
  IO.inspect(listado_detalles)

  v1 = Venta.crear(c1, [d1, d2, d3])

total = Venta.calcular_total(v1)
IO.puts("El total de la venta es: #{total}")

end

end

Main.main()
