
defmodule ConversionTemperatura do
  @doc """
  Convierte una temperatura de Celsius a Fahrenheit y Kelvin, solicitando el nombre del usuario y la temperatura en Celsius.
  Muestra el resultado utilizando un programa Java externo.
  """

  @doc """
  Ejecuta la conversión de temperatura.
  """
  def convertir do
    nombre = UtilTest.input("Ingrese su nombre: ", :string)

    celsius =
      try do
        UtilTest.input("Ingrese la temperatura en Celsius: ", :float)
      rescue
        _ ->
          UtilTest.input("Valor inválido. Ingrese la temperatura en Celsius (número con decimales): ", :float)
      end

    fahrenheit = Float.round((celsius * 9 / 5) + 32, 1)
    kelvin = Float.round(celsius + 273.15, 1)

    mensaje = "Usuario: #{nombre}\n°C: #{Float.round(celsius, 1)}\n°F: #{fahrenheit}\nK: #{kelvin}"
    System.cmd("java", ["-cp", ".", "Mensaje", mensaje])
  end
end

ConversionTemperatura.convertir()
