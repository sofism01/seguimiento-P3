defmodule Carrito do # elixir --sname cliente_descuentos descuentos_cliente.exs -> para ejecutar el cliente
  @moduledoc """
  Estructura para representar un carrito de compras.
  """
  defstruct [:id, :items, :cupon]
end

defmodule DescuentosCliente do
  @moduledoc """
  Módulo cliente que coordina la aplicación de descuentos usando nodos distribuidos.
  """
  @nombre_servicio_local :servicio_coordinador_descuentos

  @doc """
  Función principal que inicia el proceso cliente.
  """
  def main() do
    IO.puts("COORDINADOR DE DESCUENTOS DE CARRITOS INICIADO")
    IO.puts("Nodo: #{Node.self()}")

    @nombre_servicio_local
    |> registrar_servicio()

    # Intentar conectar usando el nombre real del nodo servidor
    nodo_servidor = obtener_nodo_servidor()
    IO.puts("Intentando conectar a: #{nodo_servidor}")

    establecer_conexion(nodo_servidor)
    |> iniciar_descuentos(nodo_servidor)
  end

  # Funciones privadas

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp obtener_nodo_servidor() do
    # Buscar nodos disponibles que contengan "descuentos"
    nodos_disponibles = Node.list()
    IO.puts("Nodos disponibles: #{inspect(nodos_disponibles)}")

    case Enum.find(nodos_disponibles, fn nodo ->
      nodo |> Atom.to_string() |> String.contains?("descuentos")
    end) do
      nil ->
        # Construir nombre del servidor usando el mismo hostname
        hostname = Node.self() |> Atom.to_string() |> String.split("@") |> Enum.at(1)
        String.to_atom("descuentos@#{hostname}")
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

  defp iniciar_descuentos(false, _nodo_servidor),
    do: IO.puts("No se pudo conectar con el servidor de descuentos")

  defp iniciar_descuentos(true, nodo_servidor) do
    servicio_remoto = {:servicio_descuentos, nodo_servidor}
    servicio_local = {@nombre_servicio_local, Node.self()}

    carritos = lista_carritos()

    IO.puts("\nINICIANDO APLICACIÓN DE DESCUENTOS DISTRIBUIDA")
    IO.puts("Carritos a procesar: #{length(carritos)}")

    # Mostrar información de carritos
    IO.puts("\nCarritos registrados:")
    Enum.each(carritos, fn %Carrito{id: id, items: items, cupon: cupon} ->
      total_items = Enum.sum(items)
      cupon_texto = if cupon, do: "Con cupón", else: "Sin cupón"
      IO.puts("#{id}: $#{total_items} (#{cupon_texto})")
    end)

    IO.puts("\nDescuentos aplicados:")
    IO.puts("Con cupón: 10% descuento")
    IO.puts("Sin cupón: precio normal")
    IO.puts("Sleep aleatorio: 5-15ms por carrito")

    # Aplicación secuencial distribuida
    IO.puts("\n--- DESCUENTOS SECUENCIALES ---")
    {resultados_sec, tiempo_sec} = aplicar_secuencial_distribuida(carritos, servicio_remoto, servicio_local)

    mostrar_descuentos("SECUENCIAL", resultados_sec, tiempo_sec)

    # Aplicación concurrente distribuida
    IO.puts("\n--- DESCUENTOS CONCURRENTES ---")
    {resultados_con, tiempo_con} = aplicar_concurrente_distribuida(carritos, servicio_remoto, servicio_local)

    mostrar_descuentos("CONCURRENTE", resultados_con, tiempo_con)

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

    # Estadísticas de ventas
    total_ventas = Enum.reduce(resultados_sec, 0, fn {_, total}, acc -> acc + total end)
    promedio_carrito = Float.round(total_ventas / length(carritos), 2)

    IO.puts("\nResumen de ventas:")
    IO.puts("Total de ventas: $#{Float.round(total_ventas, 2)}")
    IO.puts("Promedio por carrito: $#{promedio_carrito}")

    # Finalizar servidor
    send(servicio_remoto, {servicio_local, :fin})
    receive do
      :fin -> IO.puts("Aplicación de descuentos completada exitosamente!")
    after
      2000 -> IO.puts("Timeout esperando confirmación del servidor")
    end
  end

  defp aplicar_secuencial_distribuida(carritos, servicio_remoto, servicio_local) do
    inicio = :os.system_time(:millisecond)

    IO.puts("Aplicando descuentos secuencialmente...")

    resultados = Enum.map(carritos, fn carrito ->
      enviar_carrito(carrito, servicio_remoto, servicio_local)
      recibir_resultado()
    end)

    fin = :os.system_time(:millisecond)
    tiempo_ms = fin - inicio

    {resultados, tiempo_ms}
  end

  defp aplicar_concurrente_distribuida(carritos, servicio_remoto, servicio_local) do
    inicio = :os.system_time(:millisecond)

    IO.puts("Aplicando descuentos concurrentemente...")

    # Enviar todos los carritos
    Enum.each(carritos, fn carrito ->
      enviar_carrito(carrito, servicio_remoto, servicio_local)
    end)

    # Recibir todos los resultados
    resultados = Enum.map(carritos, fn _ -> recibir_resultado() end)

    fin = :os.system_time(:millisecond)
    tiempo_ms = fin - inicio

    {resultados, tiempo_ms}
  end

  defp enviar_carrito(carrito, servicio_remoto, servicio_local) do
    send(servicio_remoto, {servicio_local, {:aplicar_descuento, carrito}})
  end

  defp recibir_resultado() do
    receive do
      resultado -> resultado
    after
      3000 -> {"timeout", 0.0}
    end
  end

  defp lista_carritos do
    [
      %Carrito{id: "C1", items: [100, 50], cupon: true},
      %Carrito{id: "C2", items: [200], cupon: false},
      %Carrito{id: "C3", items: [75, 25, 30], cupon: true},
      %Carrito{id: "C4", items: [150, 80], cupon: false},
      %Carrito{id: "C5", items: [90], cupon: true}
    ]
  end

  defp mostrar_descuentos(tipo, resultados, tiempo_ms) do
    IO.puts("\nDescuentos #{tipo}:")
    IO.puts("Tiempo total: #{tiempo_ms} ms")

    # Mostrar todos los resultados
    IO.puts("\nCarritos procesados:")
    resultados
    |> Enum.each(fn {id, total} ->
      IO.puts("#{id}: $#{Float.round(total, 2)}")
    end)
  end
end

DescuentosCliente.main()
