defmodule Sucursal do
  @moduledoc """
  Estructura para representar una sucursal con sus ventas diarias.
  """
  defstruct [:id, :ventas_diarias]
end

defmodule ReportesSucursal do
  @moduledoc """
  Módulo para generar reportes de sucursales usando Benchmark.
  """

  # Cargar el módulo Benchmark
  Code.require_file("benchmark.ex", __DIR__)
  alias Benchmark, as: BenchmarkUtils

  @doc """
  Genera un reporte para una sucursal.
  Calcula ventas totales, promedio y top-3 ítems + sleep aleatorio.
  """
  def reporte(%Sucursal{id: id, ventas_diarias: ventas}) do
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

  @doc """
  Generación secuencial de reportes.
  """
  def generar_secuencial(sucursales) do
    IO.puts("Generando reportes secuencialmente")
    Enum.map(sucursales, &reporte/1)
  end

  @doc """
  Generación concurrente de reportes.
  """
  def generar_concurrente(sucursales) do
    IO.puts("Generando reportes concurrentemente")
    sucursales
    |> Enum.map(fn sucursal ->
      Task.async(fn -> reporte(sucursal) end)
    end)
    |> Task.await_many(15000)
  end

  @doc """
  Lista de sucursales de ejemplo.
  """
  def lista_sucursales do
    [
      %Sucursal{id: "SUC001", ventas_diarias: [1250, 980, 1100, 1350, 890, 1200, 1450]},
      %Sucursal{id: "SUC002", ventas_diarias: [2100, 1850, 2200, 1950, 2300, 2050, 1900]},
      %Sucursal{id: "SUC003", ventas_diarias: [750, 820, 690, 780, 850, 720, 800]},
      %Sucursal{id: "SUC004", ventas_diarias: [1500, 1650, 1400, 1700, 1550, 1600, 1480]},
      %Sucursal{id: "SUC005", ventas_diarias: [950, 1020, 880, 1100, 990, 1050, 970]}
    ]
  end

  @doc """
  Ejecuta la comparación usando Benchmark.
  """
  def ejecutar_comparacion do
    sucursales = lista_sucursales()

    IO.puts("GENERACIÓN DE REPORTES POR SUCURSAL")
    IO.puts("=" |> String.duplicate(55))

    IO.puts("Sucursales a procesar: #{length(sucursales)}")
    IO.puts("Proceso: ventas totales + promedio + top-3 + sleep(50-120ms)")
    # Medir secuencial
    tiempo_sec = BenchmarkUtils.determinar_tiempo_ejecucion({
      ReportesSucursal,
      :generar_secuencial,
      [sucursales]
    })

    # Medir concurrente
    tiempo_con = BenchmarkUtils.determinar_tiempo_ejecucion({
      ReportesSucursal,
      :generar_concurrente,
      [sucursales]
    })

    # Calcular speedup
    speedup = BenchmarkUtils.calcular_speedup(tiempo_con, tiempo_sec)

    # Mostrar métricas de rendimiento
    IO.puts("Resultados de rendimiento:")
    IO.puts("Tiempo secuencial: #{tiempo_sec} microsegundos")
    IO.puts("Tiempo concurrente: #{tiempo_con} microsegundos")
    IO.puts("Speedup: #{Float.round(speedup, 2)}x")

    # Mensaje del benchmark
    mensaje = BenchmarkUtils.generar_mensaje(tiempo_con, tiempo_sec)
    IO.puts("\n#{mensaje}")

    {tiempo_sec, tiempo_con, speedup}
  end
end

# Ejecutar la comparación
ReportesSucursal.ejecutar_comparacion()
