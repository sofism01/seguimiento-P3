defmodule RestauranteParalelo do
  @cantidad_platos 4

  @moduledoc """
  Módulo para simular la preparación PARALELA de platos en un restaurante.
  Varios chefs trabajan simultáneamente preparando diferentes platos.
  """

  @doc """
  Función principal para ejecutar la simulación paralela.
  """
  def main do
    IO.puts("=== SIMULACIÓN RESTAURANTE - COCINA PARALELA ===\n")
    IO.puts("Varios chefs trabajando simultáneamente...")
    tiempo_total = Benchmark.determinar_tiempo_ejecucion({RestauranteParalelo, :cocina_paralela, [@cantidad_platos]})
    IO.puts(generar_mensaje(tiempo_total))
  end

  @doc """
  Función que simula la preparación paralela de platos (varios chefs trabajando simultáneamente).
  """
  def cocina_paralela(cantidad_platos) do
    platos = [
      {"Raviolis de Pollo", 3000},
      {"Pollo en Salsa de Champiñones", 4500},
      {"Ceviche de Camarones", 2500},
      {"Sopa de Tomate", 1500}
    ]

    # Crear una tarea (Task) para cada plato - cada chef trabaja en paralelo
    tareas =
      Enum.map(platos, fn plato ->
        Task.async(fn -> preparar_plato(plato, cantidad_platos) end)
      end)

    # Esperar a que todos los chefs terminen sus platos
    Enum.each(tareas, &Task.await(&1, 30_000))
  end

  @doc """
  Función que simula la preparación de un plato específico.
  """
  def preparar_plato({nombre_plato, tiempo_prep}, cantidad_platos) do
    IO.puts("#{nombre_plato} -> (Chef iniciando preparación)")

    Enum.each(1..cantidad_platos, fn porcion ->
      :timer.sleep(tiempo_prep)
      IO.puts("#{nombre_plato} - Porción #{porcion} lista")
    end)

    IO.puts("#{nombre_plato} -> (Chef terminó todas las porciones)\n")
  end

  @doc """
  Función para generar mensaje de tiempo de ejecución.
  """
  def generar_mensaje(tiempo), do: "Tiempo total de cocina paralela: #{tiempo} microsegundos (#{Float.round(tiempo/1_000_000, 2)} segundos)"
end

RestauranteParalelo.main()
