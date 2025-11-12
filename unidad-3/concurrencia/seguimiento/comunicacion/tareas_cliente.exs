defmodule TareasCliente do # elixir --sname tareas_cliente tareas_cliente.exs -> para ejecutar el cliente
  @moduledoc """
  Cliente distribuido para ejecutar tareas de backoffice con métricas de rendimiento.
  """
  Code.require_file("benchmark.ex", __DIR__)
  alias Benchmark, as: BenchmarkUtils

  @nodo_servidor :"tareas_servidor@#{:inet.gethostname() |> elem(1)}"
  @nombre_servicio_servidor :servicio_tareas

  @doc """
  Función principal del cliente.
  """
  def main() do
    IO.puts("CLIENTE DE TAREAS BACKOFFICE")

    conectar_con_servidor()
    ejecutar_comparacion()
    finalizar_servidor()

    IO.puts("Cliente de tareas finalizado")
  end

  # Funciones privadas

  defp conectar_con_servidor() do
    Node.connect(@nodo_servidor)
  end

  defp ejecutar_comparacion do
    tareas = lote_diario()

    IO.puts("\nTAREAS BACKOFFICE DISTRIBUIDO")
    IO.puts("Tareas: #{length(tareas)}")

    tiempo_sec = BenchmarkUtils.determinar_tiempo_ejecucion(
      {__MODULE__, :ejecutar_secuencial_distribuida, [tareas]})

    tiempo_con = BenchmarkUtils.determinar_tiempo_ejecucion(
      {__MODULE__, :ejecutar_concurrente_distribuida, [tareas]})

    speedup = BenchmarkUtils.calcular_speedup(tiempo_con, tiempo_sec)

    IO.puts("\nESTADÍSTICAS:")
    IO.puts("Secuencial: #{tiempo_sec} μs")
    IO.puts("Concurrente: #{tiempo_con} μs")
    IO.puts("Speedup: #{Float.round(speedup, 2)}x")

    BenchmarkUtils.generar_mensaje(tiempo_con, tiempo_sec) |> IO.puts()
  end

  defp lote_diario do
    [:reindex, :purge_cache, :build_sitemap, :backup_db, :cleanup_logs, :send_reports]
  end

  def ejecutar_secuencial_distribuida(tareas) do
    IO.puts("\nEjecutando secuencialmente...")
    Enum.map(tareas, fn tarea ->
      send({@nombre_servicio_servidor, @nodo_servidor}, {self(), {:ejecutar_tarea, tarea}})

      receive do
        resultado -> resultado
      after
        10_000 -> "TIMEOUT"
      end
    end)
  end

  def ejecutar_concurrente_distribuida(tareas) do
    IO.puts("\n Ejecutando concurrentemente...")

    tareas
    |> Enum.map(&Task.async(fn ->
      send({@nombre_servicio_servidor, @nodo_servidor}, {self(), {:ejecutar_tarea, &1}})

      receive do
        resultado -> resultado
      after
        10_000 -> "TIMEOUT"
      end
    end))
    |> Task.await_many()
  end

  defp finalizar_servidor() do
    send({@nombre_servicio_servidor, @nodo_servidor}, {self(), :fin})

    receive do
      :fin -> IO.puts("\nServidor terminado correctamente")
    after
      5_000 -> IO.puts("\nTimeout esperando confirmación del servidor")
    end
  end
end

TareasCliente.main()
