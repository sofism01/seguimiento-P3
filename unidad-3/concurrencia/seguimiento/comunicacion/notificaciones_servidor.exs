defmodule Notif do # elixir --sname notificaciones_servidor notificaciones_servidor.exs -> para ejecutar el servidor
  defstruct [:canal, :usuario, :plantilla]
end

defmodule NotificacionesServidor do # elixir --sname notificaciones_servidor notificaciones_servidor.exs -> para ejecutar el servidor
  @moduledoc """
  Módulo servidor que procesa el envío de notificaciones por diferentes canales.
  """
  @nombre_servicio_local :servicio_notificaciones

  @doc """
  Función principal que inicia el proceso servidor.
  """
  def main() do
    IO.puts("SERVIDOR DE NOTIFICACIONES INICIADO")
    IO.puts("Nodo: #{Node.self()}")
    registrar_servicio(@nombre_servicio_local)
    procesar_notificaciones()
  end

  # Funciones privadas

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp procesar_notificaciones() do
    receive do
      {cliente, {:enviar_notificacion, notificacion}} ->
        resultado = enviar(notificacion)
        send(cliente, resultado)
        procesar_notificaciones()

      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor de notificaciones terminando...")
    end
  end

  defp enviar(%Notif{canal: canal, usuario: usuario, plantilla: plantilla}) do
    costo_por_canal = case canal do
      :push -> Enum.random(20..40)
      :email -> Enum.random(50..100)
      :sms -> Enum.random(80..150)
    end

    :timer.sleep(costo_por_canal)

    # Mostrar progreso en servidor
    IO.puts("Enviada a user #{usuario} (canal #{canal}, #{costo_por_canal}ms)")

    "Enviada a user #{usuario} (canal #{canal})"
  end
end

NotificacionesServidor.main()
