defmodule Concurrencia do
  @moduledoc """
  Módulo para probar spawn/1 y spawn/3
  """
  def saludo(msg) do
    msg |> IO.puts()
  end
end

#------------ SPAWN ----------------
#spawn -> spawn/1 spawn/3
#no retorna respuesta, solo crea un proceso y devuelve su pid
#spawn (fun)
result = spawn(fn -> IO.puts("Hola spawn/1") end)
IO.puts("PID del proceso spawn/1: #{inspect(result)}")

#spawn(Modulo, Funcion, Argumentos)

result2 = spawn(Concurrencia, :saludo, ["Hola spawn/3"])
IO.puts("PID del proceso spawn/3: #{inspect(result2)}")

#------------ TASK ----------------
#Task -> Permite crear procesos que retornan valores
#Task.async() -> Task.async/1 Task.async/3
#Task.async() -> Crea un proceso y retorna un struct Task
#Task.async(fun)
resultadoTask = Task.async(fn -> "Hola task/1" end)
IO.puts("Struct Task de task/1: #{inspect(resultadoTask)}")

#Task.async(Modulo, Funcion, Argumentos)
#Task.await() -> Espera a que el proceso termine y retorna el valor
#Task.await() -> Task.await/2
#Task.await(task, timeout // 5000)
respuesta = Task.await(resultadoTask)
IO.puts("Respuesta de Task.await/2: #{respuesta}")
