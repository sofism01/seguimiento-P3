defmodule Producto do #  elixir --sname precios precios_servidor.exs -> para ejecutar el servidor
  @moduledoc """
  Estructura para representar un producto con su información relevante.
  """
  defstruct [:nombre, :stock, :precio_sin_iva, :iva]
end

defmodule PreciosServidor do
  @moduledoc """
  Módulo servidor que procesa el cálculo de precios con IVA.
  """
  @nombre_servicio_local :servicio_precios
  @vueltas 3

  @doc """
  Función principal que inicia el proceso servidor.
  """
  def main() do
    IO.puts("SERVIDOR DE PRECIOS INICIADO")
    IO.puts("Nodo: #{Node.self()}")
    registrar_servicio(@nombre_servicio_local)
    procesar_productos()
  end

  # Funciones privadas

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp procesar_productos() do
    receive do
      {cliente, {:calcular_precio, producto}} ->
        resultado = precio_final(producto)
        send(cliente, resultado)
        procesar_productos()

      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor de precios terminando...")
    end
  end

  defp precio_final(%Producto{nombre: nombre, precio_sin_iva: precio, iva: iva}) do
    total_procesamiento =
      Enum.reduce(1..@vueltas, 0, fn _, acc ->
        :timer.sleep(1) # 1ms por cada iteración de procesamiento
        acc + 1
      end)

    precio_con_iva = precio * (1 + iva)
    IO.puts("#{nombre} procesado en #{total_procesamiento} iteraciones.")
    {nombre, precio_con_iva}
  end
end

PreciosServidor.main()
