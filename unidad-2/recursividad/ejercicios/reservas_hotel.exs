defmodule Main do
  @moduledoc """
  Módulo para calcular el total de días reservados en un hotel.
  """

  @doc """
  Función principal que ejecuta el cálculo del total de días reservados en una lista de reservas.
  """
   def main do
    reservas = [
      %{cliente: "Ana", dias: 3},
      %{cliente: "Luis", dias: 2},
      %{cliente: "Sofía", dias: 5}
    ]
    IO.puts("Total de días reservados: #{total_dias(reservas)}")
  end

  @doc """
  Calcula el total de días reservados en una lista de reservas.
  """
  def total_dias([]), do: 0 # Caso base: lista vacía
  
  def total_dias([%{dias: dias} | tail]), do: dias + total_dias(tail) # Llamada recursiva

end

Main.main()
