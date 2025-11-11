defmodule TareasBackoffice do
  # Cargar el módulo Benchmark
  Code.require_file("benchmark.ex", __DIR__)
  alias Benchmark, as: BenchmarkUtils

  def ejecutar(tarea) do
    tiempo_sleep = case tarea do
      :reindex -> Enum.random(100..200)
      :purge_cache -> Enum.random(50..80)
      :build_sitemap -> Enum.random(150..250)
      :backup_db -> Enum.random(300..500)
      :cleanup_logs -> Enum.random(30..60)
      :send_reports -> Enum.random(80..120)
    end

    :timer.sleep(tiempo_sleep)
    "OK tarea #{tarea}"
  end

  def ejecutar_secuencial(tareas), do: Enum.map(tareas, &ejecutar/1)
  def ejecutar_concurrente(tareas) do
    tareas
    |> Enum.map(&Task.async(fn -> ejecutar(&1) end))
    |> Task.await_many()
  end

  def lote_diario do
    [:reindex, :purge_cache, :build_sitemap, :backup_db, :cleanup_logs, :send_reports]
  end

  def ejecutar_comparacion do
    tareas = lote_diario()

    IO.puts("AREAS BACKOFFICE")
    IO.puts("Tareas: #{length(tareas)}")

    tiempo_sec = BenchmarkUtils.determinar_tiempo_ejecucion({__MODULE__, :ejecutar_secuencial, [tareas]})
    tiempo_con = BenchmarkUtils.determinar_tiempo_ejecucion({__MODULE__, :ejecutar_concurrente, [tareas]})
    speedup = BenchmarkUtils.calcular_speedup(tiempo_con, tiempo_sec)

    # Mostrar algunas tareas ejecutadas
    IO.puts("\nEjemplos:")
    Enum.take(ejecutar_secuencial(tareas), 3) |> Enum.each(&IO.puts/1)

    IO.puts("\nSecuencial: #{tiempo_sec} μs")
    IO.puts("Concurrente: #{tiempo_con} μs")
    IO.puts("Speedup: #{Float.round(speedup, 2)}x")

    BenchmarkUtils.generar_mensaje(tiempo_con, tiempo_sec) |> IO.puts()
  end
end

TareasBackoffice.ejecutar_comparacion()
