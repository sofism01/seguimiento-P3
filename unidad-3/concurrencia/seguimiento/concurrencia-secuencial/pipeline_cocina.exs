defmodule Orden do
  @moduledoc """
  Estructura para representar una orden de bebida/comida en la cafetería.
  """
  defstruct [:id, :item, :prep_ms]
end

defmodule Cocina do
  @moduledoc """
  Módulo para simular la preparación de órdenes en una cafetería.
  """
  @vueltas 3

  @doc """
  Función que simula la preparación de una orden.
  """
  def preparar(%Orden{id: id, item: item, prep_ms: tiempo}) do
    total_prep =
      Enum.reduce(1..@vueltas, 0, fn paso, acc ->
        :timer.sleep(tiempo)
        IO.puts("  Orden #{id} (#{item}) - Paso #{paso}/#{@vueltas}")
        acc + tiempo
      end)

    ticket = "TICKET-#{id}: #{item} - Listo en #{total_prep}ms"
    IO.puts("#{ticket}")
    {id, item, ticket, total_prep}
  end

  @doc """
  Función que procesa órdenes de forma secuencial.
  """
  def cocina_secuencial(ordenes) do
    inicio = :os.timestamp()

    IO.puts("COCINA SECUENCIAL")
    IO.puts("Procesando #{length(ordenes)} órdenes...")

    tickets = Enum.map(ordenes, &preparar/1)

    fin = :os.timestamp()
    tiempo_total = :timer.now_diff(fin, inicio) / 1000

    IO.puts("\nTiempo total secuencial: #{:erlang.float_to_binary(tiempo_total, [{:decimals, 2}])} ms")
    {tickets, tiempo_total}
  end

  @doc """
  Función que procesa órdenes de forma concurrente.
  """
  def cocina_concurrente(ordenes) do
    inicio = :os.timestamp()

    IO.puts("COCINA CONCURRENTE")
    IO.puts("Procesando #{length(ordenes)} órdenes en paralelo...")

    tickets =
      ordenes
      |> Enum.map(fn orden ->
        Task.async(fn -> preparar(orden) end)
      end)
      |> Task.await_many(30000) # timeout de 30 segundos

    fin = :os.timestamp()
    tiempo_total = :timer.now_diff(fin, inicio) / 1000

    IO.puts("\nTiempo total concurrente: #{:erlang.float_to_binary(tiempo_total, [{:decimals, 2}])} ms")
    {tickets, tiempo_total}
  end

  @doc """
  Función que genera órdenes de ejemplo para la cafetería.
  """
  def lista_ordenes do
    [
      %Orden{id: 1, item: "Café Americano", prep_ms: 200},
      %Orden{id: 2, item: "Cappuccino", prep_ms: 350},
      %Orden{id: 3, item: "Latte", prep_ms: 300},
      %Orden{id: 4, item: "Frappé", prep_ms: 500},
      %Orden{id: 5, item: "Té Verde", prep_ms: 180},
    ]
  end

  @doc """
  Genera una lista grande de órdenes aleatorias.
  """
  def generar_ordenes(cantidad \\ 20) do
    items_menu = [
      {"Café Americano", 200},
      {"Cappuccino", 350},
      {"Latte", 300},
      {"Espresso", 150},
      {"Frappé", 500},
      {"Té Verde", 180}
    ]

    Enum.map(1..cantidad, fn i ->
      {item, tiempo_base} = Enum.random(items_menu)
      variacion = :rand.uniform(40) - 20
      tiempo_final = max(50, tiempo_base + round(tiempo_base * variacion / 100))

      %Orden{
        id: i,
        item: "#{item}_#{i}",
        prep_ms: tiempo_final
      }
    end)
  end

  @doc """
  Muestra los tickets generados.
  """
  def mostrar_tickets(tickets, titulo \\ "TICKETS GENERADOS") do
    IO.puts("\n#{titulo}:")
    tickets
    |> Enum.each(fn {id, item, _ticket, tiempo} ->
      IO.puts("  [#{id}] #{String.slice(item, 0..15)}... - #{tiempo}ms")
    end)
  end

  @doc """
  Calcula el speedup entre los dos métodos.
  """
  def calcular_speedup(tiempo_secuencial, tiempo_concurrente) do
    speedup = tiempo_secuencial / tiempo_concurrente
    :erlang.float_to_binary(speedup, [{:decimals, 2}])
  end

  @doc """
  Función principal para iniciar la simulación de la cocina.
  """
  def iniciar(cantidad_ordenes \\ 8) do
    IO.puts("PIPELINE DE COCINA - CAFETERÍA")

    ordenes = if cantidad_ordenes <= 8 do
      lista_ordenes() |> Enum.take(cantidad_ordenes)
    else
      generar_ordenes(cantidad_ordenes)
    end

    IO.puts("Órdenes recibidas:")
    Enum.each(ordenes, fn %Orden{id: id, item: item, prep_ms: tiempo} ->
      IO.puts("  #{id}. #{item} (#{tiempo}ms)")
    end)


    {tickets_sec, tiempo_sec} = cocina_secuencial(ordenes)
    mostrar_tickets(tickets_sec, "TICKETS SECUENCIAL")


    {tickets_con, tiempo_con} = cocina_concurrente(ordenes)
    mostrar_tickets(tickets_con, "TICKETS CONCURRENTE")

    speedup = calcular_speedup(tiempo_sec, tiempo_con)

    IO.puts("RESUMEN DE RENDIMIENTO")
    IO.puts("Tiempo secuencial:  #{:erlang.float_to_binary(tiempo_sec, [{:decimals, 2}])} ms")
    IO.puts("Tiempo concurrente: #{:erlang.float_to_binary(tiempo_con, [{:decimals, 2}])} ms")
    IO.puts("Speedup obtenido:   #{speedup}x")

    if String.to_float(speedup) > 1.0 do
      mejora = (String.to_float(speedup) - 1.0) * 100
      IO.puts("Mejora de rendimiento: #{:erlang.float_to_binary(mejora, [{:decimals, 1}])}%")
    end

    tickets_sec_sorted = Enum.sort_by(tickets_sec, fn {id, _, _, _} -> id end)
    tickets_con_sorted = Enum.sort_by(tickets_con, fn {id, _, _, _} -> id end)

    if tickets_sec_sorted == tickets_con_sorted do
      IO.puts("Verificación: Ambos métodos procesaron las mismas órdenes")
    else
      IO.puts("Advertencia: Diferencias en el procesamiento")
    end

    IO.puts("Servicio completado exitosamente")
  end

  @doc """
  Función para probar con diferentes cantidades de órdenes.
  """
  def benchmark_ordenes do
    cantidades = [5, 10, 20, 50]

    IO.puts("BENCHMARK POR CANTIDAD DE ÓRDENES")

    Enum.each(cantidades, fn cantidad ->
      IO.puts("Probando con #{cantidad} órdenes:")
      ordenes = generar_ordenes(cantidad)

      {_, tiempo_sec} = cocina_secuencial(ordenes)
      IO.puts("")
      {_, tiempo_con} = cocina_concurrente(ordenes)

      speedup = calcular_speedup(tiempo_sec, tiempo_con)
      IO.puts("Speedup: #{speedup}x")
      IO.puts(String.duplicate("-", 40))
    end)
  end
end

Cocina.iniciar(6)
