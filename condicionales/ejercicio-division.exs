defmodule Main do
  @doc """
  Programa para realizar una división segura con manejo de condicionales.
  """

 def main do
    dividendo = Util.input("Ingrese el dividendo (entero): ", :integer)
    divisor = Util.input("Ingrese el divisor (entero): ", :integer)
    division_segura(dividendo, divisor)
  end

  @doc """
  Función para realizar la división y manejar casos especiales.
  """
  def division_segura(dividendo, divisor) do
    case divisor do
      0 -> Util.show_message("Error: División por cero no permitida")

      _ ->
        cociente = div(dividendo, divisor)
        residuo = rem(dividendo, divisor)

        case residuo do
          0 ->
            Util.show_message("División exacta. Cociente: #{cociente}")

          _ ->
            Util.show_message("División no exacta. Cociente: #{cociente}, Residuo: #{residuo}")
        end
    end
  end
end

Main.main()
