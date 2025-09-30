defmodule Main do

def main do

  c1 = %Cliente{nombre: "Juan Perez", cedula: "1234567890"}

  p1 = %Producto{nombre: "Laptop", precio: 1500.0}
  p2 = %Producto{nombre: "Mouse", precio: 25.0}
  p3 = %Producto{nombre: "Teclado", precio: 45.0}

  d1 = %Detalle{producto: p1, cantidad: 2}
  d2 = %Detalle{producto: p2, cantidad: 3}
  d3 = %Detalle{producto: p3, cantidad: 1}

  v1 = %Venta{cliente: c1, detalles: [d1, d2, d3]}

 Venta.calcular_total(v1) |> IO.puts()

end

end

Main.main()
