defmodule Main do
  @doc """
    Programa para analizar la temperatura con condicionales.
    """

  def main do

    temp = Util.input("Ingrese la temperatura actual (en Celsius y con decimales): ", :float)
    analizar_temperatura(temp)


  end

  @doc """
    Función para analizar la temperatura y mostrar un mensaje adecuado.
  """
  def analizar_temperatura(temp) do
    cond do
      temp < 15 -> Util.show_message("Hace frío")
      temp >= 15 and temp <= 25 -> Util.show_message("El clima es templado")
      temp > 25 -> Util.show_message("Hace calor")
      true -> Util.show_message("Temperatura inválida")
    end

  end

end

Main.main()
