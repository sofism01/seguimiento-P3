defmodule Producto do #  elixir --sname precios precios_servidor.exs -> para ejecutar el servidor
  @moduledoc """
  Estructura para representar un producto con su información relevante.
  """
  defstruct [:nombre, :stock, :precio_sin_iva, :iva]
end

defmodule PreciosCliente do
  @moduledoc """
  Módulo cliente que coordina el cálculo de precios usando nodos distribuidos.
  """
  @nombre_servicio_local :servicio_coordinador_precios

  @doc """
  Función principal que inicia el proceso cliente.
  """
  def main() do
    IO.puts("COORDINADOR DE PRECIOS INICIADO")
    IO.puts("Nodo: #{Node.self()}")

    @nombre_servicio_local
    |> registrar_servicio()

    # Intentar conectar usando el nombre real del nodo servidor
    nodo_servidor = obtener_nodo_servidor()
    IO.puts("Intentando conectar a: #{nodo_servidor}")

    establecer_conexion(nodo_servidor)
    |> iniciar_calculo(nodo_servidor)
  end

  # Funciones privadas

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp obtener_nodo_servidor() do
    # Buscar nodos disponibles que contengan "precios"
    nodos_disponibles = Node.list()
    IO.puts("Nodos disponibles: #{inspect(nodos_disponibles)}")

    case Enum.find(nodos_disponibles, fn nodo ->
      nodo |> Atom.to_string() |> String.contains?("precios")
    end) do
      nil ->
        # Construir nombre del servidor usando el mismo hostname
        hostname = Node.self() |> Atom.to_string() |> String.split("@") |> Enum.at(1)
        String.to_atom("precios@#{hostname}")
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

  defp iniciar_calculo(false, _nodo_servidor),
    do: IO.puts("No se pudo conectar con el servidor de precios")

  defp iniciar_calculo(true, nodo_servidor) do
    servicio_remoto = {:servicio_precios, nodo_servidor}
    servicio_local = {@nombre_servicio_local, Node.self()}

    productos = generar_productos(10)

    IO.puts("INICIANDO CÁLCULO DE PRECIOS DISTRIBUIDO")
    IO.puts("Productos a procesar: #{length(productos)}")

    # Cálculo secuencial distribuido
    IO.puts("\n--- CÁLCULO SECUENCIAL ---")
    {resultados_sec, tiempo_sec} = calcular_precios_secuencial(productos, servicio_remoto, servicio_local)

    mostrar_resultados("SECUENCIAL", resultados_sec, tiempo_sec)

    # Cálculo concurrente distribuido
    IO.puts("\n--- CÁLCULO CONCURRENTE ---")
    {resultados_con, tiempo_con} = calcular_precios_concurrente(productos, servicio_remoto, servicio_local)

    mostrar_resultados("CONCURRENTE", resultados_con, tiempo_con)

    # Calcular speedup
    speedup = if tiempo_con > 0, do: tiempo_sec / tiempo_con, else: 1.0
    IO.puts("SPEEDUP: #{Float.round(speedup, 2)}x")

    if speedup > 1.0 do
      mejora = (speedup - 1.0) * 100
      IO.puts("Mejora de rendimiento: #{Float.round(mejora, 1)}%")
    end

    # Finalizar servidor
    send(servicio_remoto, {servicio_local, :fin})
    receive do
      :fin -> IO.puts("Cálculo de precios terminado.")
    after
      2000 -> IO.puts("Timeout esperando confirmación del servidor")
    end
  end

  defp calcular_precios_secuencial(productos, servicio_remoto, servicio_local) do
    inicio = :os.system_time(:millisecond)

    resultados = Enum.map(productos, fn producto ->
      enviar_producto(producto, servicio_remoto, servicio_local)
      recibir_resultado()
    end)

    fin = :os.system_time(:millisecond)
    tiempo_ms = fin - inicio

    {resultados, tiempo_ms}
  end

  defp calcular_precios_concurrente(productos, servicio_remoto, servicio_local) do
    inicio = :os.system_time(:millisecond)

    # Enviar todos los productos
    Enum.each(productos, fn producto ->
      enviar_producto(producto, servicio_remoto, servicio_local)
    end)

    # Recibir todos los resultados
    resultados = Enum.map(productos, fn _ -> recibir_resultado() end)

    fin = :os.system_time(:millisecond)
    tiempo_ms = fin - inicio

    {resultados, tiempo_ms}
  end

  defp enviar_producto(producto, servicio_remoto, servicio_local) do
    send(servicio_remoto, {servicio_local, {:calcular_precio, producto}})
  end

  defp recibir_resultado() do
    receive do
      resultado -> resultado
    after
      5000 -> {:error, "timeout"}
    end
  end

  defp generar_productos(cantidad) do
    nombres_base = [
      "Laptop", "Mouse", "Teclado", "Monitor", "Auriculares",
      "Webcam", "Tablet", "Smartphone", "Cargador", "Cable HDMI"
    ]

    ivas_posibles = [0.19, 0.16, 0.21, 0.18] # Diferentes tipos de IVA

    Enum.map(1..cantidad, fn i ->
      nombre_base = Enum.random(nombres_base)
      %Producto{
        nombre: "#{nombre_base}_#{i}",
        stock: :rand.uniform(100),
        precio_sin_iva: :rand.uniform(1000) + 50.0, # Precio entre 50 y 1050
        iva: Enum.random(ivas_posibles)
      }
    end)
  end

  defp mostrar_resultados(tipo, resultados, tiempo_ms) do
    IO.puts("\nResultados #{tipo}:")
    IO.puts("Tiempo total: #{tiempo_ms} ms")

    # Mostrar muestra de productos procesados
    IO.puts("\nMuestra de productos procesados:")
    resultados
    |> Enum.take(5)
    |> Enum.each(fn {nombre, precio_final} ->
      precio_str = Float.round(precio_final, 2)
      IO.puts("#{nombre}: $#{precio_str}")
    end)

    if length(resultados) > 5 do
      IO.puts("  ... y #{length(resultados) - 5} productos más")
    end
  end
end

PreciosCliente.main()
