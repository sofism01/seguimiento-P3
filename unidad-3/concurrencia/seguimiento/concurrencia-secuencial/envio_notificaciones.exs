defmodule Notif do
  defstruct [:canal, :usuario, :plantilla]
end

defmodule EnvioNotificaciones do
  # Cargar el módulo Benchmark
  Code.require_file("benchmark.ex", __DIR__)
  alias Benchmark, as: BenchmarkUtils

  def enviar(%Notif{canal: canal, usuario: usuario, plantilla: plantilla}) do
    costo_por_canal = case canal do
      :push -> Enum.random(20..40)
      :email -> Enum.random(50..100)
      :sms -> Enum.random(80..150)
    end

    :timer.sleep(costo_por_canal)
    "Enviada a user #{usuario} (canal #{canal})"
  end

  def enviar_secuencial(notificaciones), do: Enum.map(notificaciones, &enviar/1)
  def enviar_concurrente(notificaciones) do
    notificaciones
    |> Enum.map(&Task.async(fn -> enviar(&1) end))
    |> Task.await_many()
  end

  def lista_notificaciones do
    [
      %Notif{canal: :push, usuario: "Ana", plantilla: "bienvenida"},
      %Notif{canal: :email, usuario: "Carlos", plantilla: "promocion"},
      %Notif{canal: :sms, usuario: "Maria", plantilla: "codigo"},
      %Notif{canal: :push, usuario: "Pedro", plantilla: "recordatorio"},
      %Notif{canal: :email, usuario: "Lucia", plantilla: "newsletter"},
      %Notif{canal: :sms, usuario: "Diego", plantilla: "alerta"}
    ]
  end

  def ejecutar_comparacion do
    notificaciones = lista_notificaciones()

    IO.puts("ENVÍO NOTIFICACIONES")
    IO.puts("Notificaciones: #{length(notificaciones)}")

    tiempo_sec = BenchmarkUtils.determinar_tiempo_ejecucion({__MODULE__, :enviar_secuencial, [notificaciones]})
    tiempo_con = BenchmarkUtils.determinar_tiempo_ejecucion({__MODULE__, :enviar_concurrente, [notificaciones]})
    speedup = BenchmarkUtils.calcular_speedup(tiempo_con, tiempo_sec)

    # Mostrar algunas notificaciones enviadas
    IO.puts("\nEjemplos:")
    Enum.take(enviar_secuencial(notificaciones), 3) |> Enum.each(&IO.puts/1)

    IO.puts("\nSecuencial: #{tiempo_sec} μs")
    IO.puts("Concurrente: #{tiempo_con} μs")
    IO.puts("Speedup: #{Float.round(speedup, 2)}x")

    BenchmarkUtils.generar_mensaje(tiempo_con, tiempo_sec) |> IO.puts()
  end
end

EnvioNotificaciones.ejecutar_comparacion()
