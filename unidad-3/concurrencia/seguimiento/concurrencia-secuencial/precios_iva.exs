defmodule Producto do
  @moduledoc """
  Estructura para representar un producto con su información relevante.
  """
  defstruct [:nombre, :stock, :precio_sin_iva, :iva]
end

defmodule CalculadoraPrecios do
  @moduledoc """
  Módulo para calcular precios de productos incluyendo IVA.
  """
  @vueltas 3

  @doc """
  Calcula el precio final de un producto incluyendo IVA
  """
  def precio_final(%Producto{nombre: nombre, precio_sin_iva: precio, iva: iva}) do
    total_procesamiento =
      Enum.reduce(1..@vueltas, 0, fn _, acc ->
        :timer.sleep(1) # 1ms por cada iteración de procesamiento
        acc + 1
      end)

    precio_con_iva = precio * (1 + iva)
    IO.puts("#{nombre} procesado en #{total_procesamiento} iteraciones.")
    {nombre, precio_con_iva}
  end

  @doc """
  Procesamiento secuencial
  """
  def calcular_precios_secuencial(productos) do
    inicio = :os.timestamp()

    resultados = Enum.map(productos, &precio_final/1)

    fin = :os.timestamp()
    tiempo_ms = :timer.now_diff(fin, inicio) / 1000

    IO.puts("Procesamiento SECUENCIAL:")
    IO.puts("  Productos procesados: #{length(productos)}")
    IO.puts("  Tiempo total: #{:erlang.float_to_binary(tiempo_ms, [{:decimals, 2}])} ms")

    {resultados, tiempo_ms}
  end

  @doc """
  Procesamiento concurrente
  """
  def calcular_precios_concurrente(productos) do
    inicio = :os.timestamp()

    resultados =
      productos
      |> Enum.map(fn producto ->
        Task.async(fn -> precio_final(producto) end)
      end)
      |> Task.await_many(10000) # timeout de 10 segundos

    fin = :os.timestamp()
    tiempo_ms = :timer.now_diff(fin, inicio) / 1000

    IO.puts("Procesamiento CONCURRENTE:")
    IO.puts("  Productos procesados: #{length(productos)}")
    IO.puts("  Tiempo total: #{:erlang.float_to_binary(tiempo_ms, [{:decimals, 2}])} ms")

    {resultados, tiempo_ms}
  end

  @doc """
  Genera una lista de productos aleatorios para pruebas.
  """
  def generar_productos(cantidad \\ 5000) do
    nombres_base = [
      "Laptop", "Mouse", "Teclado", "Monitor", "Auriculares",
      "Webcam", "Tablet", "Smartphone", "Cargador", "Cable HDMI",
      "Memoria USB", "Disco Duro", "Procesador", "Tarjeta Gráfica", "RAM",
      "Motherboard", "Fuente Poder", "Gabinete", "Cooler", "SSD"
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

  @doc """
  Calcula el speedup entre los dos métodos.
  """
  def calcular_speedup(tiempo_secuencial, tiempo_concurrente) do
    speedup = tiempo_secuencial / tiempo_concurrente
    :erlang.float_to_binary(speedup, [{:decimals, 2}])
  end

  @doc """
  Muestra una muestra de los resultados procesados.
  """
  def mostrar_muestra(resultados, cantidad \\ 10) do
    IO.puts("\nMuestra de productos procesados:")
    resultados
    |> Enum.take(cantidad)
    |> Enum.each(fn {nombre, precio_final} ->
      precio_str = :erlang.float_to_binary(precio_final, [{:decimals, 2}])
      IO.puts("  #{nombre}: $#{precio_str}")
    end)

    if length(resultados) > cantidad do
      IO.puts("  ... y #{length(resultados) - cantidad} productos más")
    end
  end

  @doc """
  Función para calcular el speedup entre dos tiempos de ejecución.
  """
  def iniciar(cantidad_productos \\ 5000) do
    IO.puts("CALCULADORA DE PRECIOS CON IVA")
    IO.puts("Generando #{cantidad_productos} productos...")

    productos = generar_productos(cantidad_productos)
    IO.puts("Productos generados exitosamente.\n")

    {resultados_sec, tiempo_sec} = calcular_precios_secuencial(productos)
    mostrar_muestra(resultados_sec, 5)

    {resultados_con, tiempo_con} = calcular_precios_concurrente(productos)
    mostrar_muestra(resultados_con, 5)

    # Calcular speedup
    speedup = calcular_speedup(tiempo_sec, tiempo_con)

    IO.puts("RESUMEN DE RENDIMIENTO")
    IO.puts("Tiempo secuencial:  #{:erlang.float_to_binary(tiempo_sec, [{:decimals, 2}])} ms")
    IO.puts("Tiempo concurrente: #{:erlang.float_to_binary(tiempo_con, [{:decimals, 2}])} ms")
    IO.puts("Speedup obtenido:   #{speedup}x")

    if String.to_float(speedup) > 1.0 do
      mejora = (String.to_float(speedup) - 1.0) * 100
      IO.puts("Mejora de rendimiento: #{:erlang.float_to_binary(mejora, [{:decimals, 1}])}%")
    end

    IO.puts("\nProcesamiento terminado exitosamente!")

    if Enum.sort(resultados_sec) == Enum.sort(resultados_con) do
      IO.puts("Verificación: Ambos métodos produjeron resultados idénticos")
    else
      IO.puts("Advertencia: Los resultados difieren entre métodos")
    end
  end

  @doc """
  Función para ejecutar benchmarks con diferentes tamaños de listas de productos.
  """
  def benchmark_por_tamaños do
    tamaños = [1000, 2500, 5000, 10000]

    IO.puts("BENCHMARK POR TAMAÑOS")

    Enum.each(tamaños, fn tamaño ->
      IO.puts("Probando con #{tamaño} productos:")
      productos = generar_productos(tamaño)

      {_, tiempo_sec} = calcular_precios_secuencial(productos)
      {_, tiempo_con} = calcular_precios_concurrente(productos)

      speedup = calcular_speedup(tiempo_sec, tiempo_con)
      IO.puts("  Speedup: #{speedup}x")
      IO.puts("")
    end)
  end
end

CalculadoraPrecios.iniciar(10)
