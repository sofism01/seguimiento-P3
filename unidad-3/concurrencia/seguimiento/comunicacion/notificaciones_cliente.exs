defmodule Notif do # elixir --sname notificaciones_cliente notificaciones_cliente.exs -> para ejecutar el cliente
  defstruct [:canal, :usuario, :plantilla]
end

defmodule NotificacionesCliente do # elixir --sname notificaciones_cliente notificaciones_cliente.exs -> para ejecutar el cliente
  @moduledoc """
  Cliente distribuido para enviar notificaciones con métricas de rendimiento.
  """
  Code.require_file("benchmark.ex", __DIR__)
  alias Benchmark, as: BenchmarkUtils

  @nodo_servidor :"notificaciones_servidor@#{:inet.gethostname() |> elem(1)}"
  @nombre_servicio_servidor :servicio_notificaciones

  @doc """
  Función principal del cliente.
  """
  def main() do
    IO.puts("CLIENTE DE NOTIFICACIONES")

    conectar_con_servidor()
    ejecutar_comparacion()
    finalizar_servidor()

    IO.puts("Cliente de notificaciones finalizado")
  end

  # Funciones privadas

  defp conectar_con_servidor() do
    Node.connect(@nodo_servidor)
  end

  defp ejecutar_comparacion do
    notificaciones = lista_notificaciones()

    IO.puts("\nENVÍO NOTIFICACIONES DISTRIBUIDO")
    IO.puts("Notificaciones: #{length(notificaciones)}")
    IO.puts("Canales: push (20-40ms), email (50-100ms), sms (80-150ms)")

    tiempo_sec = BenchmarkUtils.determinar_tiempo_ejecucion(
      {__MODULE__, :enviar_secuencial_distribuida, [notificaciones]})

    tiempo_con = BenchmarkUtils.determinar_tiempo_ejecucion(
      {__MODULE__, :enviar_concurrente_distribuida, [notificaciones]})

    speedup = BenchmarkUtils.calcular_speedup(tiempo_con, tiempo_sec)

    mostrar_estadisticas_notificaciones(notificaciones)

    IO.puts("\nESTADÍSTICAS:")
    IO.puts("Secuencial: #{tiempo_sec} μs")
    IO.puts("Concurrente: #{tiempo_con} μs")
    IO.puts("Speedup: #{Float.round(speedup, 2)}x")

    BenchmarkUtils.generar_mensaje(tiempo_con, tiempo_sec) |> IO.puts()
  end

  defp lista_notificaciones do
    [
      %Notif{canal: :push, usuario: "Ana", plantilla: "bienvenida"},
      %Notif{canal: :email, usuario: "Carlos", plantilla: "promocion"},
      %Notif{canal: :sms, usuario: "Maria", plantilla: "codigo"},
      %Notif{canal: :push, usuario: "Pedro", plantilla: "recordatorio"},
      %Notif{canal: :email, usuario: "Lucia", plantilla: "newsletter"},
      %Notif{canal: :sms, usuario: "Diego", plantilla: "alerta"}
    ]
  end

  def enviar_secuencial_distribuida(notificaciones) do
    IO.puts("\nEnviando secuencialmente...")
    Enum.map(notificaciones, fn notificacion ->
      send({@nombre_servicio_servidor, @nodo_servidor}, {self(), {:enviar_notificacion, notificacion}})

      receive do
        resultado -> resultado
      after
        10_000 -> "TIMEOUT"
      end
    end)
  end

  def enviar_concurrente_distribuida(notificaciones) do
    IO.puts("\nEnviando concurrentemente...")

    notificaciones
    |> Enum.map(&Task.async(fn ->
      send({@nombre_servicio_servidor, @nodo_servidor}, {self(), {:enviar_notificacion, &1}})

      receive do
        resultado -> resultado
      after
        10_000 -> "TIMEOUT"
      end
    end))
    |> Task.await_many()
  end

  defp mostrar_estadisticas_notificaciones(notificaciones) do
    por_canal = Enum.group_by(notificaciones, & &1.canal)

    IO.puts("\nRESUMEN DE NOTIFICACIONES:")
    Enum.each(por_canal, fn {canal, lista} ->
      IO.puts("  #{canal}: #{length(lista)} notificaciones")
    end)
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

NotificacionesCliente.main()
