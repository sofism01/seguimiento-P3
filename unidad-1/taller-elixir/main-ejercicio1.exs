
defmodule ConsumoConductor do
  @moduledoc """
  Módulo para calcular el rendimiento de combustible de un conductor.
  """

  @doc """
  Calcula el rendimiento de combustible y muestra el resultado.
  """
  def calcular do
    nombre = UtilTest.input("Ingrese el nombre del conductor: ", :string)

    distancia =
      try do
        UtilTest.input("Ingrese la distancia recorrida en km: ", :float)
      rescue
        _ ->
          UtilTest.input("Valor inválido. Ingrese la distancia recorrida en km (número con decimales): ", :float)
      end

    litros =
      try do
        UtilTest.input("Ingrese la cantidad de combustible consumido en litros: ", :float)
      rescue
        _ ->
          UtilTest.input("Valor inválido. Ingrese la cantidad de combustible consumido en litros (número con decimales): ", :float)
      end

    rendimiento =
      try do
        distancia / litros
      rescue
        ArithmeticError -> 0.0
      end

    mensaje = "Conductor: #{nombre}\nRendimiento: #{Float.round(rendimiento, 2)} km/L"
    System.cmd("java", ["-cp", ".", "Mensaje", mensaje])
  end
end

ConsumoConductor.calcular()
