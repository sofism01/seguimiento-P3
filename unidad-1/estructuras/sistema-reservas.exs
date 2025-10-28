defmodule Main do
  @doc """
    Programa para gestionar un sistema de reservas
    """

  def main do

    reservas = crear_reservas()
    calcular_dias(reservas)
    obtener_reserva(reservas)
    convertir_reserva(reservas)

  end

  @doc """
    Función para crear una lista de reservas.
    """
  def crear_reservas do
    reservas = [
      %{cliente: "Juan", habitacion: 101, dias: 3},
      %{cliente: "Sofia", habitacion: 102, dias: 6},
      %{cliente: "Carlos", habitacion: 103, dias: 1}
    ]
    Util.show_message("Lista de reservas: #{inspect(reservas)}")
    reservas
  end

  @doc """
    Función para calcular el total de días reservados.
    """
  def calcular_dias(reservas) do
    total_dias = Enum.reduce(reservas, 0, fn reserva, acc -> acc + reserva.dias end)
    Util.show_message("Total de días reservados: #{total_dias}")
  end

  @doc """
    Función para obtener una reserva con más de 5 días.
    """
  def obtener_reserva(reservas) do
   reservas = Enum.find(reservas, fn reserva -> reserva.dias > 5 end)
    Util.show_message("Reserva con más de 5 días: #{inspect(reservas)}")
  end

  @doc """
    Función para convertir la primera reserva a una lista de tuplas y mostrar el cliente.
    """
  def convertir_reserva(reservas) do
    primera_reserva = Enum.at(reservas, 0)
    mapa = Map.to_list(primera_reserva)
    IO.inspect(mapa)
    cliente = primera_reserva.cliente
    Util.show_message("Cliente de la primera reserva: #{cliente}")
  end

end

Main.main()
