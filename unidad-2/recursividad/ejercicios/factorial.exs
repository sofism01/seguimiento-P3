defmodule Main do
  @moduledoc """
  Módulo para calcular el factorial de un número de forma recursiva.
  """
  @doc """
  Función principal que solicita un número al usuario y muestra el resultado del factorial.
  """
  def main do
    n = IO.gets("Ingrese un número (entero) para calcular su factorial: ")
      |> String.trim()
      |> String.to_integer()
    resultado = factorial(n)
    IO.puts("El resultado es: #{resultado}")
  end

  @doc """
  Calcula el factorial de un número de forma recursiva.
  """
  def factorial(n) when n < 0 do
    "Error: el número no puede ser negativo"
  end

  def factorial(0), do: 1 # Caso base

  def factorial(n) when n > 0 do # Llamado recursivo con guarda
    n * factorial(n - 1)
  end
end

Main.main()
