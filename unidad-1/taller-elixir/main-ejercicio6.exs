
defmodule CostoEnvio do
  @doc """
  Calcula el costo de envío de un paquete y retorna una tupla con {cliente, peso, tipo_envio, costo_total}.
  """

  @doc """
  Ejecuta el cálculo del costo de envío.
  """
  def calcular do
    cliente = UtilTest.input("Ingrese el nombre del cliente: ", :string)
    peso =
      try do
        UtilTest.input("Ingrese el peso del paquete en kg: ", :float)
      rescue
        _ ->
          UtilTest.input("Valor inválido. Ingrese el peso en kg (número con decimales): ", :float)
      end

    tipo_envio = UtilTest.input("Ingrese el tipo de envío (Económico, Express, Internacional): ", :string)
    tipo_envio_limpio = String.downcase(String.trim(tipo_envio))

    costo_total =
      case tipo_envio_limpio do
        "economico" -> 5_000 * peso
        "express" -> 8_000 * peso
        "internacional" ->
          cond do
            peso <= 5 -> 15_000 * peso
            peso > 5 -> 12_000 * peso
          end
        _ -> 0
      end

    # Ejemplo de uso de if para mostrar advertencia si el costo es 0
    if costo_total == 0 do
      System.cmd("java", ["-cp", ".", "Mensaje", "Tipo de envío no válido."])
    end

    mensaje = "Cliente: #{cliente}\nPeso: #{Float.round(peso, 2)} kg\nTipo de envío: #{tipo_envio}\nCosto total: $#{Float.round(costo_total, 2)}"
    System.cmd("java", ["-cp", ".", "Mensaje", mensaje])

    {cliente, peso, tipo_envio, costo_total}
  end
end

CostoEnvio.calcular()
