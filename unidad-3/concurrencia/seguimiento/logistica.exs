defmodule Paquete do
  @moduledoc """
  Estructura para representar un paquete en el sistema logístico.
  """
  defstruct [:id, :peso, :fragil?]
end

defmodule Logistica do
  @moduledoc """
  Módulo para simular la preparación de paquetes usando Benchmark.
  """

  @doc """
  Función que simula la preparación completa de un paquete.
  Hace 2-3 sleeps según los flags del paquete.
  """
  def preparar(%Paquete{id: id, peso: peso, fragil?: fragil?}) do
    inicio = :os.timestamp()

    # Paso 1: Etiquetar (siempre se hace) - 1er sleep
    :timer.sleep(100)

    # Paso 2: Pesar (siempre se hace) - 2do sleep
    :timer.sleep(150)

    # Paso 3: Embalar (3er sleep solo si es frágil o pesado)
    if fragil? or peso > 5.0 do
      :timer.sleep(200)  # 3er sleep
    end

    fin = :os.timestamp()
    tiempo_ms = :timer.now_diff(fin, inicio) / 1000

    {id, tiempo_ms}
  end

  @doc """
  Preparación secuencial de paquetes.
  """
  def preparar_secuencial(paquetes) do
    Enum.map(paquetes, &preparar/1)
  end

  @doc """
  Preparación concurrente de paquetes.
  """
  def preparar_concurrente(paquetes) do
    paquetes
    |> Enum.map(fn paquete ->
      Task.async(fn -> preparar(paquete) end)
    end)
    |> Task.await_many(10000)
  end

  @doc """
  Genera paquetes de ejemplo.
  """
  def lista_paquetes do
    [
      %Paquete{id: "PKG001", peso: 2.5, fragil?: false},
      %Paquete{id: "PKG002", peso: 8.0, fragil?: true},
      %Paquete{id: "PKG003", peso: 1.2, fragil?: false},
      %Paquete{id: "PKG004", peso: 6.5, fragil?: false},
      %Paquete{id: "PKG005", peso: 3.8, fragil?: true}
    ]
  end

  @doc """
  Ejecuta la comparación usando Benchmark.
  """
  def ejecutar_comparacion do
    paquetes = lista_paquetes()

    IO.puts("=== PREPARACIÓN DE PAQUETES CON BENCHMARK ===")
    IO.puts("Paquetes: #{length(paquetes)}")

    # Medir secuencial
    tiempo_sec = Benchmark.determinar_tiempo_ejecucion({
      Logistica,
      :preparar_secuencial,
      [paquetes]
    })

    # Medir concurrente
    tiempo_con = Benchmark.determinar_tiempo_ejecucion({
      Logistica,
      :preparar_concurrente,
      [paquetes]
    })

    # Calcular speedup
    speedup = Benchmark.calcular_speedup(tiempo_con, tiempo_sec)

    # Mostrar resultados
    IO.puts("\nTiempo secuencial: #{tiempo_sec} microsegundos")
    IO.puts("Tiempo concurrente: #{tiempo_con} microsegundos")
    IO.puts("Speedup: #{Float.round(speedup, 2)}x")

    # Mensaje del benchmark
    mensaje = Benchmark.generar_mensaje(tiempo_con, tiempo_sec)
    IO.puts("\n#{mensaje}")
  end
end

Logistica.ejecutar_comparacion()
