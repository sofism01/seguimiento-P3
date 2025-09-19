defmodule Main do
  @moduledoc """
  Módulo para calcular la potencia de un número utilizando recursión.
  """
  @doc """
  Función principal que muestra ejemplos de cálculo de potencia.
  """
    def main do
    IO.puts(potencia(2, 3))
    IO.puts(potencia(5, 0))
    IO.puts(potencia(3, 4))
  end

  @doc """
  Calcula la potencia de un número utilizando recursión.
  """
  def potencia(_, 0), do: 1  # Caso base: un número elevado a la 0 es 1

  def potencia(base, exponente), do: base * potencia(base, exponente - 1)   # Llamada recursiva

end

Main.main()
