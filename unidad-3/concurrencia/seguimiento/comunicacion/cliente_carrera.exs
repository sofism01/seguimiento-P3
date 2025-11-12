defmodule Car do #  elixir --sname carrera cliente_carrera.exs -> para ejecutar el cliente
  @moduledoc """
  Estructura para representar un auto en la carrera.
  """
  defstruct [:id, :piloto, :pit_ms, :vuelta_ms]
end

defmodule CarreraCliente do
  @moduledoc """
  Módulo cliente que coordina la carrera de autos usando nodos distribuidos.
  """
  @nombre_servicio_local :servicio_coordinador

  @doc """
  Función principal que inicia el proceso cliente.
  """
  def main() do
    IO.puts("COORDINADOR DE CARRERA INICIADO")
    IO.puts("Nodo: #{Node.self()}")

    @nombre_servicio_local
    |> registrar_servicio()

    # Intentar conectar usando el nombre real del nodo servidor
    nodo_servidor = obtener_nodo_servidor()
    IO.puts("Intentando conectar a: #{nodo_servidor}")

    establecer_conexion(nodo_servidor)
    |> iniciar_carrera(nodo_servidor)
  end

  # Funciones privadas

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp obtener_nodo_servidor() do
    # Buscar nodos disponibles que contengan "servidor"
    nodos_disponibles = Node.list()
    IO.puts("Nodos disponibles: #{inspect(nodos_disponibles)}")

    # Si no hay nodos, usar el nombre por defecto
    case Enum.find(nodos_disponibles, fn nodo ->
      nodo |> Atom.to_string() |> String.contains?("servidor")
    end) do
      nil ->
        # Construir nombre del servidor usando el mismo hostname
        hostname = Node.self() |> Atom.to_string() |> String.split("@") |> Enum.at(1)
        String.to_atom("servidor@#{hostname}")
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

  defp iniciar_carrera(false, _nodo_servidor),
    do: IO.puts("No se pudo conectar con el servidor de carrera")

  defp iniciar_carrera(true, nodo_servidor) do
    servicio_remoto = {:servicio_carrera, nodo_servidor}
    servicio_local = {@nombre_servicio_local, Node.self()}

    autos = lista_autos()

    IO.puts("INICIANDO CARRERA DISTRIBUIDA")
    IO.puts("Autos participantes: #{length(autos)}")

    # Carrera secuencial distribuida
    IO.puts("\n--- CARRERA SECUENCIAL ---")
    inicio_sec = :os.system_time(:millisecond)
    ranking_sec = carrera_secuencial_distribuida(autos, servicio_remoto, servicio_local)
    fin_sec = :os.system_time(:millisecond)
    tiempo_sec = fin_sec - inicio_sec

    mostrar_ranking("SECUENCIAL", ranking_sec, tiempo_sec)

    # Carrera concurrente distribuida
    IO.puts("\n--- CARRERA CONCURRENTE ---")
    inicio_con = :os.system_time(:millisecond)
    ranking_con = carrera_concurrente_distribuida(autos, servicio_remoto, servicio_local)
    fin_con = :os.system_time(:millisecond)
    tiempo_con = fin_con - inicio_con

    mostrar_ranking("CONCURRENTE", ranking_con, tiempo_con)

    # Calcular speedup
    speedup = if tiempo_con > 0, do: tiempo_sec / tiempo_con, else: 1.0
    IO.puts("SPEEDUP: #{Float.round(speedup, 2)}x")

    # Finalizar servidor
    send(servicio_remoto, {servicio_local, :fin})
    receive do
      :fin -> IO.puts("Carrera terminada.")
    after
      2000 -> IO.puts("Timeout esperando confirmación del servidor")
    end
  end

  defp carrera_secuencial_distribuida(autos, servicio_remoto, servicio_local) do
    Enum.map(autos, fn auto ->
      enviar_auto(auto, servicio_remoto, servicio_local)
      recibir_resultado()
    end)
    |> Enum.sort_by(fn {_piloto, tiempo} -> tiempo end)
  end

  defp carrera_concurrente_distribuida(autos, servicio_remoto, servicio_local) do
    # Enviar todos los autos
    Enum.each(autos, fn auto ->
      enviar_auto(auto, servicio_remoto, servicio_local)
    end)

    # Recibir todos los resultados
    Enum.map(autos, fn _ -> recibir_resultado() end)
    |> Enum.sort_by(fn {_piloto, tiempo} -> tiempo end)
  end

  defp enviar_auto(auto, servicio_remoto, servicio_local) do
    send(servicio_remoto, {servicio_local, {:simular_auto, auto}})
  end

  defp recibir_resultado() do
    receive do
      resultado -> resultado
    after
      10000 -> {:error, "timeout"}
    end
  end

  defp lista_autos do
    [
      %Car{id: 1, piloto: "Hamilton", vuelta_ms: 200, pit_ms: 100},
      %Car{id: 2, piloto: "Verstappen", vuelta_ms: 180, pit_ms: 80},
      %Car{id: 3, piloto: "Alonso", vuelta_ms: 220, pit_ms: 120},
      %Car{id: 4, piloto: "Leclerc", vuelta_ms: 190, pit_ms: 90}
    ]
  end

  defp mostrar_ranking(tipo, ranking, tiempo_ms) do
    IO.puts("\nRanking #{tipo}:")
    Enum.with_index(ranking, 1)
    |> Enum.each(fn {{piloto, tiempo}, pos} ->
      IO.puts("  #{pos}. #{piloto} - #{tiempo} ms")
    end)
    IO.puts("Tiempo total de #{String.downcase(tipo)}: #{tiempo_ms} ms")
  end
end

CarreraCliente.main()
