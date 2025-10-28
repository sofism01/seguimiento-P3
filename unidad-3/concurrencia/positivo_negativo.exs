# ----------------- SECUENCIAL------------------------

defmodule Main do
  @moduledoc """
  Función que identifica si un número es positivo o negativo de forma SECUENCIAL.
  """

  @doc """
  Función principal con una lista de números.
  """
  def main do
    lista = [5, -3, 8, -1, 12, -7, 2, -9]

    IO.puts("ANÁLISIS SECUENCIAL")

    # Medir el tiempo de ejecución usando Benchmark
    tiempo = Benchmark.determinar_tiempo_ejecucion({__MODULE__, :procesar_lista, [lista]})
    # tiempo = Benchmark.determinar_tiempo_ejecucion({Main, :procesar_lista, [lista]}) -> Alternativa válida con el mismo resultado


    IO.puts("Tiempo total de ejecución: #{tiempo} microsegundos")
    IO.puts("Tiempo en segundos: #{Float.round(tiempo / 1_000_000, 2)} segundos")
  end

  @doc """
  Función para procesar toda la lista (necesaria para el benchmark).
  """
  def procesar_lista(lista) do
    Enum.each(lista, fn numero ->
      identificar_numero(numero)
    end)
  end

  def identificar_numero(numero) do
    :timer.sleep(1000)  # Espera 1 segundo
    if numero > 0 do
      IO.puts("#{numero} es POSITIVO")
    else
      IO.puts("#{numero} es NEGATIVO")
    end
  end
end

# ----------------- CONCURRENTE------------------------

defmodule MainConcurrente do
  @moduledoc """
  Función que identifica si un número es positivo o negativo de forma CONCURRENTE.
  """

  @doc """
  Función principal con una lista de números.
  """
  def main do
    lista = [5, -3, 8, -1, 12, -7, 2, -9]

    IO.puts("ANÁLISIS CONCURRENTE")

    # Medir el tiempo de ejecución usando Benchmark
    tiempo = Benchmark.determinar_tiempo_ejecucion({__MODULE__, :procesar_lista_concurrente, [lista]})

    IO.puts("Tiempo total de ejecución: #{tiempo} microsegundos")
    IO.puts("Tiempo en segundos: #{Float.round(tiempo / 1_000_000, 2)} segundos")
  end

  @doc """
  Función para procesar toda la lista de forma concurrente.
  """
def procesar_lista_concurrente(lista) do
    # Crear una tarea (Task) para cada número - EJECUTAN EN PARALELO
    tareas =
      Enum.map(lista, fn numero ->
        Task.async(fn -> identificar_numero(numero) end)
      end)

    Enum.each(tareas, &Task.await(&1, 10_000))
  end

  def identificar_numero(numero) do
    :timer.sleep(1000)  # Espera 1 segundo (simula procesamiento)
    if numero > 0 do
      IO.puts("#{numero} es POSITIVO")
    else
      IO.puts("#{numero} es NEGATIVO")
    end
  end
end

Main.main()
MainConcurrente.main()
