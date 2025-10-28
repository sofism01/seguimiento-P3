
defmodule InventarioLibro do
  @moduledoc """
  Módulo para registrar libros en un inventario.
  """

  @doc """
  Registra un libro solicitando título, cantidad y precio unitario, y muestra un mensaje con el valor total.
  """
  def registrar do
    titulo = UtilTest.input("Ingrese el título del libro: ", :string)

    cantidad =
      try do
        UtilTest.input("Ingrese la cantidad de unidades disponibles: ", :integer)
      rescue
        ArgumentError ->
          UtilTest.input("Ingrese la cantidad de unidades disponibles: ", :integer)
      end

    precio =
      try do
        UtilTest.input("Ingrese el precio unitario: ", :float)
      rescue
        ArgumentError ->
          UtilTest.input("Valor inválido. Ingrese el precio unitario con decimales: ", :float)
      end

    valor_total = cantidad * precio
    valor_formateado = :erlang.float_to_binary(valor_total, decimals: 0) |> String.replace(".", ",")
    mensaje = "El libro \"#{titulo}\" tiene #{cantidad} unidades, con un valor total de $#{valor_formateado}."

    System.cmd("java", ["-cp", ".", "Mensaje", mensaje])
  end
end

InventarioLibro.registrar()
