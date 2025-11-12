defmodule TareasServidor do # elixir --sname tareas_servidor tareas_servidor.exs -> para ejecutar el servidor
  @moduledoc """
  Módulo servidor que procesa la ejecución de tareas de backoffice.
  """
  @nombre_servicio_local :servicio_tareas

  @doc """
  Función principal que inicia el proceso servidor.
  """
  def main() do
    IO.puts("SERVIDOR DE TAREAS BACKOFFICE INICIADO")
    IO.puts("Nodo: #{Node.self()}")
    registrar_servicio(@nombre_servicio_local)
    procesar_tareas()
  end

  # Funciones privadas

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp procesar_tareas() do
    receive do
      {cliente, {:ejecutar_tarea, tarea}} ->
        resultado = ejecutar(tarea)
        send(cliente, resultado)
        procesar_tareas()

      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor de tareas terminando...")
    end
  end

  defp ejecutar(tarea) do
    tiempo_sleep = case tarea do
      :reindex -> Enum.random(100..200)
      :purge_cache -> Enum.random(50..80)
      :build_sitemap -> Enum.random(150..250)
      :backup_db -> Enum.random(300..500)
      :cleanup_logs -> Enum.random(30..60)
      :send_reports -> Enum.random(80..120)
    end

    :timer.sleep(tiempo_sleep)

    # Mostrar progreso en servidor
    IO.puts("OK tarea #{tarea} (#{tiempo_sleep}ms)")

    "OK tarea #{tarea}"
  end
end

TareasServidor.main()
