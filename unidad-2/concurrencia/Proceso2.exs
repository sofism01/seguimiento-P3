defmodule Proceso do
  @cantidad_procesos_internos 5
@moduledoc """
  Módulo para simular la ejecución de varios procesos con demoras específicas de forma paralela.
  """

@doc """
  Función principal para iniciar la simulación de procesos.
"""
def main do
Benchmark.determinar_tiempo_ejecucion({Proceso, :simulacion, [@cantidad_procesos_internos]})
|> generar_mensaje()
|> Util.show_message()
end

@doc """
  Función que simula la ejecución de varios procesos con demoras específicas.
  """
def simulacion(cantidad_procesos_internos) do
datos_prueba = [{"A", 2500}, {"\tB", 1500}, {"\t\tC", 500}, {"\t\t\tD", 3500}]
tarea =
Enum.map(datos_prueba, fn valor ->
Task.async(fn -> simulando_proceso(valor, cantidad_procesos_internos) end)
end)
# Si se omite el último valor, por defecto es 5000 milisegundos
Enum.each(tarea, &Task.await(&1, 100_000))
end

@doc """
  Función que simula un proceso con una demora específica.
  """
def simulando_proceso({mensaje, demora}, cantidad_procesos_internos) do
IO.puts("#{mensaje} -> (Inicia)")
Enum.each(1..cantidad_procesos_internos, fn i ->
:timer.sleep(demora)
IO.puts("\t#{mensaje}-#{i}")
end)
IO.puts("#{mensaje} -> (Finalizada)")
end

@doc """
  Función para calcular el speedup entre dos tiempos de ejecución.
"""
def generar_mensaje(tiempo), do: "\nEl tiempo de ejecución es de #{tiempo} microsegundos."
end

Proceso.main()
