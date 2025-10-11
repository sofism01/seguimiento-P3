defmodule Producto do
  @moduledoc """
  Estructura para representar un producto con IVA calculado.
  """
  defstruct codigo: "", nombre: "", precio: 0.0, iva: 0.0, precio_con_iva: 0.0
end

defmodule Main do
  @tasa_iva 0.19

  def main do
    p1 = crear_producto_con_iva("P001", "Laptop", 1500000)
    p2 = crear_producto_con_iva("P002", "Mouse", 25000)
    p3 = crear_producto_con_iva("P003", "Teclado",80000)
    p4 = crear_producto_con_iva("P004", "Monitor", 450000)

    productos = [p1, p2, p3, p4]

    escribir_csv(productos, "productos_con_iva.csv")

    productos_leidos = leer_csv("productos_con_iva.csv")
    IO.inspect(productos_leidos, label: "Productos leídos desde CSV")
  end

  @doc """
  Crea un producto con IVA y precio con IVA calculados.
  """
  def crear_producto_con_iva(codigo, nombre, precio) do
    iva = Float.round(precio * @tasa_iva, 2)
    precio_con_iva = Float.round(precio + iva, 2)
    %Producto{
      codigo: codigo,
      nombre: nombre,
      precio: precio,
      iva: iva,
      precio_con_iva: precio_con_iva
    }
  end
  
@doc """
Lee una lista de productos desde un archivo CSV.
"""
def leer_csv(nombre_archivo) do
  case File.read(nombre_archivo) do
    {:ok, contenido} ->
      String.split(contenido, "\n")
      |> Enum.map(&String.trim/1)
      |> Enum.filter(fn line -> line != "" end)
      |> Enum.map(fn line ->
        case String.split(line, ", ") do  # Cambiado de "," a ", "
          ["codigo", "nombre", "precio"] -> nil # ignorar headers
          ["codigo", "nombre", "precio", "iva", "precio_con_iva"] -> nil # ignorar headers del archivo con IVA
          [codigo, nombre, precio_str] ->
            try do
              precio = String.to_float(precio_str)
              %Producto{codigo: String.trim(codigo), nombre: String.trim(nombre), precio: precio}
            rescue
              ArgumentError ->
                # Si no es float, intentar como entero
                try do
                  precio = String.to_integer(precio_str) |> Kernel./(1.0)
                  %Producto{codigo: String.trim(codigo), nombre: String.trim(nombre), precio: precio}
                rescue
                  ArgumentError -> nil
                end
            end
          [codigo, nombre, precio_str, iva_str, precio_con_iva_str] ->
            # Manejo para archivos que ya tienen IVA calculado
            try do
              precio = String.to_float(precio_str)
              iva = String.to_float(iva_str)
              precio_con_iva = String.to_float(precio_con_iva_str)
              %Producto{
                codigo: String.trim(codigo),
                nombre: String.trim(nombre),
                precio: precio,
                iva: iva,
                precio_con_iva: precio_con_iva
              }
            rescue
              ArgumentError -> nil
            end
          _ -> nil
        end
      end)
      |> Enum.filter(&(&1 != nil))

    {:error, reason} ->
      IO.puts("Error al leer el archivo: #{reason}")
      []
  end
end

  @doc """
  Escribe una lista de productos en un archivo CSV.
  """
  def escribir_csv(list_productos, nombre_archivo) do
    headers = "codigo, nombre, precio, iva, precio_con_iva\n"

    contenido =
      Enum.map(list_productos, fn %Producto{codigo: codigo, nombre: nombre, precio: precio, iva: iva, precio_con_iva: precio_con_iva} ->
        "#{codigo}, #{nombre}, #{precio}, #{iva}, #{precio_con_iva}\n"
      end)
      |> Enum.join()

    File.write(nombre_archivo, headers <> contenido)
  end
end

Main.main()
