
defmodule PeajeVehiculo do
  @doc """
  Registra información de vehículos que pasan por el peaje y calcula la tarifa final.
  Retorna una tupla con {placa, tipo, tarifa_final}.
  """

  @doc """
  Solicita la placa, tipo y peso del vehículo, calcula la tarifa y muestra un mensaje con el resultado.
  """
  def registrar do
    placa = UtilTest.input("Ingrese la placa del vehículo: ", :string)
    tipo = UtilTest.input("Ingrese el tipo de vehículo (Carro, Moto, Camión): ", :string)

    peso =
      try do
        UtilTest.input("Ingrese el peso del vehículo en toneladas: ", :float)
      rescue
        _ ->
          UtilTest.input("Valor inválido. Ingrese el peso en toneladas (número con decimales): ", :float)
      end

    tarifa =
      case String.downcase(String.trim(tipo)) do
        "carro" -> 10_000
        "moto" -> 5_000
        "camion" ->
          if peso > 1 do
            20_000 + trunc((peso) * 2_000)

          end
      end

    mensaje = "Placa: #{placa}\nTipo: #{tipo}\nTarifa final: $#{tarifa}"
    System.cmd("java", ["-cp", ".", "Mensaje", mensaje])

    {placa, tipo, tarifa}
  end
end

PeajeVehiculo.registrar()
