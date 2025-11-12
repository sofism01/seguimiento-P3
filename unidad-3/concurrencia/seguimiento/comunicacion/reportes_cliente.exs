defmodule Sucursal do # elixir --sname reportes reportes_servidor.exs -> para ejecutar el servidor
  @moduledoc """
  Estructura para representar una sucursal con sus ventas diarias.
  """
  defstruct [:id, :ventas_diarias]
end

defmodule ReportesCliente do
  @moduledoc """
  Módulo cliente que coordina la generación de reportes usando nodos distribuidos.
  """
  @nombre_servicio_local :servicio_coordinador_reportes

  @doc """
  Función principal que inicia el proceso cliente.
  """
  def main() do
    IO.puts("COORDINADOR DE REPORTES DE SUCURSAL INICIADO")
    IO.puts("Nodo: #{Node.self()}")

    @nombre_servicio_local
    |> registrar_servicio()

    # Intentar conectar usando el nombre real del nodo servidor
    nodo_servidor = obtener_nodo_servidor()
    IO.puts("Intentando conectar a: #{nodo_servidor}")

    establecer_conexion(nodo_servidor)
    |> iniciar_reportes(nodo_servidor)
  end

  # Funciones privadas

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp obtener_nodo_servidor() do
    # Buscar nodos disponibles que contengan "reportes"
    nodos_disponibles = Node.list()
    IO.puts("Nodos disponibles: #{inspect(nodos_disponibles)}")

    case Enum.find(nodos_disponibles, fn nodo ->
      nodo |> Atom.to_string() |> String.contains?("reportes")
    end) do
      nil ->
        # Construir nombre del servidor usando el mismo hostname
        hostname = Node.self() |> Atom.to_string() |> String.split("@") |> Enum.at(1)
        String.to_atom("reportes@#{hostname}")
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

  defp iniciar_reportes(false, _nodo_servidor),
    do: IO.puts("No se pudo conectar con el servidor de reportes")

  defp iniciar_reportes(true, nodo_servidor) do
    servicio_remoto = {:servicio_reportes, nodo_servidor}
    servicio_local = {@nombre_servicio_local, Node.self()}

    sucursales = lista_sucursales()

    IO.puts("\nINICIANDO GENERACIÓN DE REPORTES DISTRIBUIDA")
    IO.puts("Sucursales a procesar: #{length(sucursales)}")

    # Mostrar información de sucursales
    IO.puts("\nSucursales registradas:")
    Enum.each(sucursales, fn %Sucursal{id: id, ventas_diarias: ventas} ->
      total_ventas = Enum.sum(ventas)
      IO.puts("#{id}: $#{total_ventas} (#{length(ventas)} días)")
    end)

    # Generación secuencial distribuida
    IO.puts("\n--- REPORTES SECUENCIALES ---")
    {reportes_sec, tiempo_sec} = generar_secuencial_distribuida(sucursales, servicio_remoto, servicio_local)

    mostrar_reportes("SECUENCIAL", reportes_sec, tiempo_sec)

    # Generación concurrente distribuida
    IO.puts("\n--- REPORTES CONCURRENTES ---")
    {reportes_con, tiempo_con} = generar_concurrente_distribuida(sucursales, servicio_remoto, servicio_local)

    mostrar_reportes("CONCURRENTE", reportes_con, tiempo_con)

    # Calcular speedup
    speedup = if tiempo_con > 0, do: tiempo_sec / tiempo_con, else: 1.0
    IO.puts("\nRESUMEN DE RENDIMIENTO:")
    IO.puts("Tiempo secuencial: #{tiempo_sec} ms")
    IO.puts("Tiempo concurrente: #{tiempo_con} ms")
    IO.puts("Speedup: #{Float.round(speedup, 2)}x")

    if speedup > 1.0 do
      mejora = (speedup - 1.0) * 100
      IO.puts("Mejora de rendimiento: #{Float.round(mejora, 1)}%")
    end

    IO.puts("\nProceso aplicado:")
    IO.puts("Ventas totales y promedio")
    IO.puts("Top-3 mejores días de venta")
    IO.puts("Sleep aleatorio: 50-120ms por sucursal")

    # Finalizar servidor
    send(servicio_remoto, {servicio_local, :fin})
    receive do
      :fin -> IO.puts("Generación de reportes completada exitosamente!")
    after
      2000 -> IO.puts("Timeout esperando confirmación del servidor")
    end
  end

  defp generar_secuencial_distribuida(sucursales, servicio_remoto, servicio_local) do
    inicio = :os.system_time(:millisecond)

    IO.puts("Generando reportes secuencialmente...")

    reportes = Enum.map(sucursales, fn sucursal ->
      enviar_sucursal(sucursal, servicio_remoto, servicio_local)
      recibir_reporte()
    end)

    fin = :os.system_time(:millisecond)
    tiempo_ms = fin - inicio

    {reportes, tiempo_ms}
  end

  defp generar_concurrente_distribuida(sucursales, servicio_remoto, servicio_local) do
    inicio = :os.system_time(:millisecond)

    IO.puts("Generando reportes concurrentemente...")

    # Enviar todas las sucursales
    Enum.each(sucursales, fn sucursal ->
      enviar_sucursal(sucursal, servicio_remoto, servicio_local)
    end)

    # Recibir todos los reportes
    reportes = Enum.map(sucursales, fn _ -> recibir_reporte() end)

    fin = :os.system_time(:millisecond)
    tiempo_ms = fin - inicio

    {reportes, tiempo_ms}
  end

  defp enviar_sucursal(sucursal, servicio_remoto, servicio_local) do
    send(servicio_remoto, {servicio_local, {:generar_reporte, sucursal}})
  end

  defp recibir_reporte() do
    receive do
      reporte -> reporte
    after
      5000 -> %{error: "timeout"}
    end
  end

  defp lista_sucursales do
    [
      %Sucursal{id: "SUC001", ventas_diarias: [1250, 980, 1100, 1350, 890, 1200, 1450]},
      %Sucursal{id: "SUC002", ventas_diarias: [2100, 1850, 2200, 1950, 2300, 2050, 1900]},
      %Sucursal{id: "SUC003", ventas_diarias: [750, 820, 690, 780, 850, 720, 800]},
      %Sucursal{id: "SUC004", ventas_diarias: [1500, 1650, 1400, 1700, 1550, 1600, 1480]},
      %Sucursal{id: "SUC005", ventas_diarias: [950, 1020, 880, 1100, 990, 1050, 970]}
    ]
  end

  defp mostrar_reportes(tipo, reportes, tiempo_ms) do
    IO.puts("\nReportes #{tipo}:")
    IO.puts("Tiempo total: #{tiempo_ms} ms")

    # Mostrar resumen de reportes
    IO.puts("\nResumen de reportes generados:")
    reportes
    |> Enum.each(fn reporte ->
      case reporte do
        %{sucursal: id, total: total, promedio: promedio, top3: top3} ->
          top3_str = top3 |> Enum.map(&to_string/1) |> Enum.join(", ")
          IO.puts("#{id}: Total=$#{total}, Promedio=$#{promedio}, Top3=[#{top3_str}]")
        %{error: _} ->
          IO.puts("Error procesando sucursal")
      end
    end)
  end
end

ReportesCliente.main()
