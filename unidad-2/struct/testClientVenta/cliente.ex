defmodule Cliente do
  @moduledoc """
  Módulo que define la estructura de un cliente.
  """
  defstruct nombre: "", cedula: ""

  @doc """
  Crea un nuevo cliente.
  """
  def crear(nombre, cedula) do
    %Cliente{nombre: nombre, cedula: cedula}
  end


  @doc """
  Escribe una lista de clientes en un archivo CSV.
  """
  def escribir_csv(list_clientes, nombre_archivo) do
    headers = "Nombre, Cédula \n"

      contenido =
      Enum.map(list_clientes,
      fn %Cliente{nombre: nombre, cedula: cedula} ->
        "#{nombre}, #{cedula}\n"
      end)
      |> Enum.join()

      File.write(nombre_archivo, headers <> contenido) # anadir [append: true] como 3er parametro para agregar al final del archivo
  end


  @doc """
  Lee una lista de clientes desde un archivo CSV.
  """
  def leer_csv(nombre_archivo) do

    case File.read(nombre_archivo) do # Case para manejar errores
      {:ok, contenido} -> # Si se lee correctamente
       String.split(contenido, "\n") # separar linea por linea
         |> Enum.map(fn line -> # recorrer cada linea
         case String.split(line, ", ") do # separar por coma y espacio
           ["Nombre", "Cédula"] -> nil # ignorar la primera linea (headers)
           [nombre, cedula] -> # verificar pattern matching
            %Cliente{nombre: nombre, cedula: cedula} # crear struct
           _ -> nil # si no coincide, retornar nil
         end

       end)

       {:error, reason} -> # Si hay un error al leer el archivo
        IO.puts("Error al leer el archivo: #{reason}") # mostrar mensaje de error
        []
  end

end

end
