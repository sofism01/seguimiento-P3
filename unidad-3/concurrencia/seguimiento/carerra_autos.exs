defmodule Car do
  @moduledoc """
  Estructura para representar un auto en la carrera.
  """
  defstruct [:id, :piloto, :pit_ms, :vuelta_ms]
end

defmodule Carrera do
  @moduledoc """
  Módulo para simular una carrera de autos de forma secuencial y concurrente.
  """
  @vueltas 3

  @doc """
  Función que simula la carrera de un auto.
  """
  def simular_carrera(%Car{piloto: piloto, vuelta_ms: vms, pit_ms: pms}) do
    total =
      Enum.reduce(1..@vueltas, 0, fn _, acc ->
        :timer.sleep(vms)
        acc + vms
      end)

    total_total = total + pms
    IO.puts("#{piloto} terminó con #{total_total} ms.")
    {piloto, total_total}
  end

  @doc """
  Función que simula la carrera de autos de forma secuencial.
  """
  def carrera_secuencial(autos) do
    Enum.map(autos, &simular_carrera/1)
    |> Enum.sort_by(fn {_piloto, tiempo} -> tiempo end)
  end

  @doc """
  Función que simula la carrera de autos de forma concurrente.
  """
  def carrera_concurrente(autos) do

    Enum.map(autos, fn auto ->
      Task.async(fn -> simular_carrera(auto) end)
    end)
    |> Task.await_many()
    |> Enum.sort_by(fn {_piloto, tiempo} -> tiempo end)
  end

  @doc """
  Función que genera la lista de autos participantes.
  """
    def lista_autos do
    [
      %Car{id: 1, piloto: "Hamilton", vuelta_ms: 800, pit_ms: 400},
      %Car{id: 2, piloto: "Verstappen", vuelta_ms: 750, pit_ms: 300},
      %Car{id: 3, piloto: "Alonso", vuelta_ms: 820, pit_ms: 500},
      %Car{id: 4, piloto: "Leclerc", vuelta_ms: 790, pit_ms: 350}
    ]
  end

  @doc """
  Función principal para iniciar la simulación de la carrera.
  """
  def iniciar do
    autos = lista_autos()

    ranking1 = carrera_secuencial(autos)
    IO.puts("\nRanking SECUNCIAL:")
    Enum.each(ranking1, fn {piloto, tiempo} ->
      IO.puts("  #{piloto} - #{tiempo} ms")
    end)
    IO.puts("\n\n\n\n")

    ranking2 = carrera_concurrente(autos)
    IO.puts("\nRanking CONCURRENTE:")
    Enum.each(ranking2, fn {piloto, tiempo} ->
      IO.puts("  #{piloto} - #{tiempo} ms")
    end)

    IO.puts("\nSimulación terminada.\n")
  end
end


Carrera.iniciar()
