defmodule Sucursal do # elixir --sname reportes reportes_servidor.exs -> para ejecutar el servidor
  @moduledoc """
  Estructura para representar una sucursal con sus ventas diarias.
  """
  defstruct [:id, :ventas_diarias]
end

defmodule ReportesServidor do
  @moduledoc """
  Módulo servidor que procesa la generación de reportes de sucursales.
  """
  @nombre_servicio_local :servicio_reportes

  @doc """
  Función principal que inicia el proceso servidor.
  """
  def main() do
    IO.puts("SERVIDOR DE REPORTES DE SUCURSAL INICIADO")
    IO.puts("Nodo: #{Node.self()}")
    registrar_servicio(@nombre_servicio_local)
    procesar_reportes()
  end

  # Funciones privadas

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp procesar_reportes() do
    receive do
      {cliente, {:generar_reporte, sucursal}} ->
        resultado = reporte(sucursal)
        send(cliente, resultado)
        procesar_reportes()

      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor de reportes terminando...")
    end
  end

  defp reporte(%Sucursal{id: id, ventas_diarias: ventas}) do
    # Simular tiempo de procesamiento variable
    tiempo_sleep = Enum.random(50..120)
    :timer.sleep(tiempo_sleep)

    # Calcular estadísticas básicas
    total_ventas = Enum.sum(ventas)
    promedio = if length(ventas) > 0, do: total_ventas / length(ventas), else: 0

    # Obtener top-3 ventas
    top3 = ventas
    |> Enum.sort(:desc)
    |> Enum.take(3)

    # Imprimir resultado
    IO.puts("Reporte listo Sucursal #{id}")

    # Retornar resumen del reporte
    %{
      sucursal: id,
      total: total_ventas,
      promedio: Float.round(promedio, 2),
      top3: top3
    }
  end
end

ReportesServidor.main()
