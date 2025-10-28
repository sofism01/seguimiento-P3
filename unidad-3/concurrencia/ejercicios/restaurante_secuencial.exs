defmodule RestauranteSecuencial do
  @cantidad_platos 4

  @moduledoc """
  Módulo para simular la preparación SECUENCIAL de platos en un restaurante.
  Un solo chef prepara todos los platos uno por uno, el chef debe terminar un plato
  antes de comenzar el siguiente.
  """

  @doc """
  Función principal para ejecutar la simulación secuencial.
  """
  def main do
    IO.puts("=== RESTAURANTE - COCINA SECUENCIAL ===\n")
    IO.puts("Un solo chef prepara todos los platos...")
    tiempo_total = Benchmark.determinar_tiempo_ejecucion({RestauranteSecuencial, :cocina_secuencial, [@cantidad_platos]})
    IO.puts(generar_mensaje(tiempo_total))
  end

  @doc """
  Función que simula la preparación secuencial de platos (un chef hace todo).
  """
  def cocina_secuencial(cantidad_platos) do
    platos = [
      {"Raviolis de Pollo", 3000},
      {"Pollo en Salsa de Champiñones", 4500},
      {"Ceviche de Camarones", 2500},
      {"Sopa de Tomate", 1500}
    ]

    Enum.each(platos, fn plato ->
      preparar_plato(plato, cantidad_platos)
    end)
  end

  @doc """
  Función que simula la preparación de un plato específico.
  """
  def preparar_plato({nombre_plato, tiempo_prep}, cantidad_platos) do
    IO.puts("#{nombre_plato} -> (Iniciando preparación)")

    Enum.each(1..cantidad_platos, fn porcion ->
      :timer.sleep(tiempo_prep)
      IO.puts(" #{nombre_plato} - Porción #{porcion} lista")
    end)

    IO.puts("#{nombre_plato} -> (Plato completado)\n")
  end

  @doc """
  Función para generar mensaje de tiempo de ejecución.
  """
  def generar_mensaje(tiempo), do: "Tiempo total de cocina: #{tiempo} microsegundos (#{Float.round(tiempo/1_000_000, 2)} segundos)"
end

RestauranteSecuencial.main()
