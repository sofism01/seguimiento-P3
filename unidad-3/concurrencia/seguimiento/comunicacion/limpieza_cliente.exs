defmodule Review do # elixir --sname cliente_limpieza limpieza_cliente.exs -> para ejecutar el cliente
  @moduledoc """
  Estructura para representar una reseña de cliente.
  """
  defstruct [:id, :texto]
end

defmodule LimpiezaCliente do
  @moduledoc """
  Módulo cliente que coordina la limpieza de reseñas usando nodos distribuidos.
  """
  @nombre_servicio_local :servicio_coordinador_limpieza

  @doc """
  Función principal que inicia el proceso cliente.
  """
  def main() do
    IO.puts("COORDINADOR DE LIMPIEZA DE RESEÑAS INICIADO")
    IO.puts("Nodo: #{Node.self()}")

    @nombre_servicio_local
    |> registrar_servicio()

    # Intentar conectar usando el nombre real del nodo servidor
    nodo_servidor = obtener_nodo_servidor()
    IO.puts("Intentando conectar a: #{nodo_servidor}")

    establecer_conexion(nodo_servidor)
    |> iniciar_limpieza(nodo_servidor)
  end

  # Funciones privadas

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp obtener_nodo_servidor() do
    # Buscar nodos disponibles que contengan "limpieza"
    nodos_disponibles = Node.list()
    IO.puts("Nodos disponibles: #{inspect(nodos_disponibles)}")

    case Enum.find(nodos_disponibles, fn nodo ->
      nodo |> Atom.to_string() |> String.contains?("limpieza")
    end) do
      nil ->
        # Construir nombre del servidor usando el mismo hostname
        hostname = Node.self() |> Atom.to_string() |> String.split("@") |> Enum.at(1)
        String.to_atom("limpieza@#{hostname}")
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

  defp iniciar_limpieza(false, _nodo_servidor),
    do: IO.puts("No se pudo conectar con el servidor de limpieza")

  defp iniciar_limpieza(true, nodo_servidor) do
    servicio_remoto = {:servicio_limpieza, nodo_servidor}
    servicio_local = {@nombre_servicio_local, Node.self()}

    resenas = lista_resenas()

    IO.puts("\nINICIANDO LIMPIEZA DE RESEÑAS DISTRIBUIDA")
    IO.puts("Reseñas a procesar: #{length(resenas)}")

    # Mostrar algunas reseñas originales
    IO.puts("\nEjemplos de reseñas originales:")
    Enum.take(resenas, 3)
    |> Enum.each(fn %Review{id: id, texto: texto} ->
      texto_corto = if String.length(texto) > 50 do
        String.slice(texto, 0, 50) <> "..."
      else
        texto
      end
      IO.puts("#{id}: \"#{texto_corto}\"")
    end)

    # Limpieza secuencial distribuida
    IO.puts("\n--- LIMPIEZA SECUENCIAL ---")
    {resultados_sec, tiempo_sec} = limpiar_secuencial_distribuida(resenas, servicio_remoto, servicio_local)

    mostrar_resultados("SECUENCIAL", resultados_sec, tiempo_sec)

    # Limpieza concurrente distribuida
    IO.puts("\n--- LIMPIEZA CONCURRENTE ---")
    {resultados_con, tiempo_con} = limpiar_concurrente_distribuida(resenas, servicio_remoto, servicio_local)

    mostrar_resultados("CONCURRENTE", resultados_con, tiempo_con)

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

    IO.puts("\nProceso aplicado:")
    IO.puts("Convertir a minúsculas")
    IO.puts("Quitar tildes y caracteres especiales")
    IO.puts("Remover stopwords comunes")
    IO.puts("Crear resumen con 5 palabras clave")
    IO.puts("Sleep aleatorio: 5-15ms por reseña")
    # Finalizar servidor
    send(servicio_remoto, {servicio_local, :fin})
    receive do
      :fin -> IO.puts("Limpieza de reseñas completada exitosamente!")
    after
      2000 -> IO.puts("Timeout esperando confirmación del servidor")
    end
  end

  defp limpiar_secuencial_distribuida(resenas, servicio_remoto, servicio_local) do
    inicio = :os.system_time(:millisecond)

    IO.puts("Procesando #{length(resenas)} reseñas secuencialmente...")

    resultados = Enum.map(resenas, fn resena ->
      enviar_resena(resena, servicio_remoto, servicio_local)
      recibir_resultado()
    end)

    fin = :os.system_time(:millisecond)
    tiempo_ms = fin - inicio

    {resultados, tiempo_ms}
  end

  defp limpiar_concurrente_distribuida(resenas, servicio_remoto, servicio_local) do
    inicio = :os.system_time(:millisecond)

    IO.puts("Procesando #{length(resenas)} reseñas en paralelo...")

    # Enviar todas las reseñas
    Enum.each(resenas, fn resena ->
      enviar_resena(resena, servicio_remoto, servicio_local)
    end)

    # Recibir todos los resultados
    resultados = Enum.map(resenas, fn _ -> recibir_resultado() end)

    fin = :os.system_time(:millisecond)
    tiempo_ms = fin - inicio

    {resultados, tiempo_ms}
  end

  defp enviar_resena(resena, servicio_remoto, servicio_local) do
    send(servicio_remoto, {servicio_local, {:limpiar_resena, resena}})
  end

  defp recibir_resultado() do
    receive do
      resultado -> resultado
    after
      5000 -> {:error, "timeout"}
    end
  end

  defp lista_resenas do
    [
      %Review{id: "R001", texto: "Este producto es muy bueno, lo recomiendo muchísimo. Excelente calidad y precio."},
      %Review{id: "R002", texto: "No me gustó para nada, llegó dañado y el servicio al cliente es pésimo."},
      %Review{id: "R003", texto: "Perfecto para lo que necesitaba. Rápida entrega y bien empaquetado."},
      %Review{id: "R004", texto: "La calidad no es la esperada por el precio que pagué. Muy decepcionante."},
      %Review{id: "R005", texto: "Increíble producto! Superó mis expectativas. Definitivamente compraré de nuevo."},
      %Review{id: "R006", texto: "Regular, ni bueno ni malo. Cumple con lo básico pero nada extraordinario."},
      %Review{id: "R007", texto: "Excelente atención y el producto llegó antes de tiempo. Muy satisfecho."},
      %Review{id: "R008", texto: "Tuve problemas con el envío pero el producto final está bien. Mejorable."}
    ]
  end

  defp mostrar_resultados(tipo, resultados, tiempo_ms) do
    IO.puts("\nResultados #{tipo}:")
    IO.puts("Tiempo total: #{tiempo_ms} ms")

    # Mostrar algunos resultados limpios
    IO.puts("\nEjemplos de resultados:")
    resultados
    |> Enum.take(4)
    |> Enum.each(fn {id, resumen} ->
      IO.puts("#{id}: \"#{resumen}\"")
    end)

    if length(resultados) > 4 do
      IO.puts("  ... y #{length(resultados) - 4} reseñas más")
    end
  end
end

LimpiezaCliente.main()
