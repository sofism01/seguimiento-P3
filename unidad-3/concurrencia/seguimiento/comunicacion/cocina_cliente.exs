defmodule Orden do #  elixir --sname cocina cocina_cliente.exs -> para ejecutar el cliente
  @moduledoc """
  Estructura para representar una orden de bebida/comida en la cafetería.
  """
  defstruct [:id, :item, :prep_ms]
end

defmodule CocinaCliente do
  @moduledoc """
  Módulo cliente que coordina las órdenes de cocina usando nodos distribuidos.
  """
  @nombre_servicio_local :servicio_coordinador_cocina

  @doc """
  Función principal que inicia el proceso cliente.
  """
  def main() do
    IO.puts("COORDINADOR DE COCINA INICIADO")
    IO.puts("Nodo: #{Node.self()}")

    @nombre_servicio_local
    |> registrar_servicio()

    # Intentar conectar usando el nombre real del nodo servidor
    nodo_servidor = obtener_nodo_servidor()
    IO.puts("Intentando conectar a: #{nodo_servidor}")

    establecer_conexion(nodo_servidor)
    |> iniciar_servicio(nodo_servidor)
  end

  # Funciones privadas

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp obtener_nodo_servidor() do
    # Buscar nodos disponibles que contengan "cocina"
    nodos_disponibles = Node.list()
    IO.puts("Nodos disponibles: #{inspect(nodos_disponibles)}")

    case Enum.find(nodos_disponibles, fn nodo ->
      nodo |> Atom.to_string() |> String.contains?("cocina")
    end) do
      nil ->
        # Construir nombre del servidor usando el mismo hostname
        hostname = Node.self() |> Atom.to_string() |> String.split("@") |> Enum.at(1)
        String.to_atom("cocina@#{hostname}")
      nodo -> nodo
    end
  end

  defp establecer_conexion(nodo_remoto) do
    case Node.connect(nodo_remoto) do
      true ->
        IO.puts("Conectado exitosamente a #{nodo_remoto}")
        true
      false ->
        IO.puts("No se pudo conectar a #{nodo_remoto}")
        false
      :ignored ->
        IO.puts("Conexión ignorada (ya existe)")
        true
    end
  end

  defp iniciar_servicio(false, _nodo_servidor),
    do: IO.puts("No se pudo conectar con el servidor de cocina")

  defp iniciar_servicio(true, nodo_servidor) do
    servicio_remoto = {:servicio_cocina, nodo_servidor}
    servicio_local = {@nombre_servicio_local, Node.self()}

    ordenes = lista_ordenes()

    IO.puts("\nINICIANDO PIPELINE DE COCINA DISTRIBUIDO")
    IO.puts("Órdenes recibidas:")
    Enum.each(ordenes, fn %Orden{id: id, item: item, prep_ms: tiempo} ->
      IO.puts("  #{id}. #{item} (#{tiempo}ms)")
    end)

    # Procesamiento secuencial distribuido
    IO.puts("\n--- COCINA SECUENCIAL ---")
    {tickets_sec, tiempo_sec} = cocina_secuencial_distribuida(ordenes, servicio_remoto, servicio_local)

    mostrar_tickets(tickets_sec, "TICKETS SECUENCIAL", tiempo_sec)

    # Procesamiento concurrente distribuido
    IO.puts("\n--- COCINA CONCURRENTE ---")
    {tickets_con, tiempo_con} = cocina_concurrente_distribuida(ordenes, servicio_remoto, servicio_local)

    mostrar_tickets(tickets_con, "TICKETS CONCURRENTE", tiempo_con)

    # Calcular speedup
    speedup = if tiempo_con > 0, do: tiempo_sec / tiempo_con, else: 1.0
    IO.puts("RESUMEN DE RENDIMIENTO:")
    IO.puts("Tiempo secuencial: #{tiempo_sec} ms")
    IO.puts("Tiempo concurrente: #{tiempo_con} ms")
    IO.puts("Speedup: #{Float.round(speedup, 2)}x")

    if speedup > 1.0 do
      mejora = (speedup - 1.0) * 100
      IO.puts("Mejora de rendimiento: #{Float.round(mejora, 1)}%")
    end

    # Verificar que ambos métodos procesaron las mismas órdenes
    tickets_sec_sorted = Enum.sort_by(tickets_sec, fn {id, _, _, _} -> id end)
    tickets_con_sorted = Enum.sort_by(tickets_con, fn {id, _, _, _} -> id end)

    if tickets_sec_sorted == tickets_con_sorted do
      IO.puts("Verificación: Ambos métodos procesaron las mismas órdenes")
    else
      IO.puts("Advertencia: Diferencias en el procesamiento")
    end

    # Finalizar servidor
    send(servicio_remoto, {servicio_local, :fin})
    receive do
      :fin -> IO.puts("Servicio de cocina completado exitosamente!")
    after
      2000 -> IO.puts("Timeout esperando confirmación del servidor")
    end
  end

  defp cocina_secuencial_distribuida(ordenes, servicio_remoto, servicio_local) do
    inicio = :os.system_time(:millisecond)

    IO.puts("Procesando #{length(ordenes)} órdenes secuencialmente...")

    tickets = Enum.map(ordenes, fn orden ->
      enviar_orden(orden, servicio_remoto, servicio_local)
      recibir_ticket()
    end)

    fin = :os.system_time(:millisecond)
    tiempo_ms = fin - inicio

    {tickets, tiempo_ms}
  end

  defp cocina_concurrente_distribuida(ordenes, servicio_remoto, servicio_local) do
    inicio = :os.system_time(:millisecond)

    IO.puts("Procesando #{length(ordenes)} órdenes en paralelo...")

    # Enviar todas las órdenes
    Enum.each(ordenes, fn orden ->
      enviar_orden(orden, servicio_remoto, servicio_local)
    end)

    # Recibir todos los tickets
    tickets = Enum.map(ordenes, fn _ -> recibir_ticket() end)

    fin = :os.system_time(:millisecond)
    tiempo_ms = fin - inicio

    {tickets, tiempo_ms}
  end

  defp enviar_orden(orden, servicio_remoto, servicio_local) do
    send(servicio_remoto, {servicio_local, {:preparar_orden, orden}})
  end

  defp recibir_ticket() do
    receive do
      ticket -> ticket
    after
      10000 -> {:error, "timeout"}
    end
  end

  defp lista_ordenes do
    [
      %Orden{id: 1, item: "Café Americano", prep_ms: 50},
      %Orden{id: 2, item: "Cappuccino", prep_ms: 80},
      %Orden{id: 3, item: "Latte", prep_ms: 70},
      %Orden{id: 4, item: "Frappé", prep_ms: 120},
      %Orden{id: 5, item: "Té Verde", prep_ms: 40},
      %Orden{id: 6, item: "Espresso", prep_ms: 30}
    ]
  end

  defp mostrar_tickets(tickets, titulo, tiempo_ms) do
    IO.puts("\n#{titulo}:")
    IO.puts("Tiempo total: #{tiempo_ms} ms")

    tickets
    |> Enum.each(fn {id, item, _ticket, tiempo_prep} ->
      item_corto = String.slice(item, 0..15)
      IO.puts("  [#{id}] #{item_corto}... - #{tiempo_prep}ms")
    end)
  end
end

CocinaCliente.main()
