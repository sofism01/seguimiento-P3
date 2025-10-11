defmodule Detalle do
  @moduledoc """
  Módulo que define la estructura de un detalle de venta.
  """
  defstruct producto: nil, cantidad: 0

  def calcular_subtotal(%Detalle{producto: producto, cantidad: cantidad}) do
    producto.precio * cantidad
  end

  @doc """
  Crea un nuevo detalle de venta.
  """
  def crear(producto, cantidad) do
    %Detalle{producto: producto, cantidad: cantidad}
  end

  @doc """
  Escribe una lista de detalles en un archivo CSV.
  """
 def escribir_csv(list_detalles, nombre_archivo) do
  headers = "Producto, Cantidad, Subtotal\n"

  contenido =
    Enum.map(list_detalles, fn %Detalle{producto: producto, cantidad: cantidad} ->
      subtotal = calcular_subtotal(%Detalle{producto: producto, cantidad: cantidad})
      "#{producto.nombre}, #{cantidad}, #{subtotal}\n"
    end)
    |> Enum.join()

  File.write(nombre_archivo, headers <> contenido) # anadir [append: true] como 3er parametro para agregar al final del archivo
end

@doc """
Lee una lista de detalles desde un archivo CSV.
"""
def leer_csv(nombre_archivo) do
  case File.read(nombre_archivo) do # Case para manejar errores
    {:ok, contenido} -> # Si se lee correctamente
      String.split(contenido, "\n") # separar linea por linea
      |> Enum.map(fn line -> # recorrer cada linea
        case String.split(line, ", ") do # separar por coma y espacio
          ["Producto", "Cantidad", "Subtotal"] -> nil # ignorar la primera linea (headers)
          [nombre_producto, cantidad_str, _subtotal_str] -> # verificar pattern matching
            # Crear producto y detalle (asumiendo precio por defecto)
            producto = %Producto{nombre: nombre_producto, precio: 0.0}
            cantidad = String.to_integer(cantidad_str)
            %Detalle{producto: producto, cantidad: cantidad} # crear struct
          _ -> nil # si no coincide, retornar nil
        end
      end)
      |> Enum.filter(& &1) # filtrar los nil

    {:error, reason} -> # Si hay un error al leer el archivo
      IO.puts("Error al leer el archivo: #{reason}") # mostrar mensaje de error
      []
  end
end


end
