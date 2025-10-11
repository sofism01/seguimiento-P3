defmodule Main do
  def main do
    lista1 = [3, 5, 8, 2, 1]
    objetivo1 = 10
    IO.puts("Lista: #{inspect(lista1)}, Objetivo: #{objetivo1}")
    IO.puts("Resultado: #{inspect(suma_objetivo(lista1, objetivo1))}")

    lista2 = [1, 2, 3, 4, 5]
    objetivo2 = 9
    IO.puts("Lista: #{inspect(lista2)}, Objetivo: #{objetivo2}")
    IO.puts("Resultado: #{inspect(suma_objetivo(lista2, objetivo2))}")

    lista3 = [2, 4, 6]
    objetivo3 = 5
    IO.puts("Lista: #{inspect(lista3)}, Objetivo: #{objetivo3}")
    IO.puts("Resultado: #{inspect(suma_objetivo(lista3, objetivo3))}")

    lista4 = [10, 5, 2, 3]
    objetivo4 = 15
    IO.puts("Lista: #{inspect(lista4)}, Objetivo: #{objetivo4}")
    IO.puts("Resultado: #{inspect(suma_objetivo(lista4, objetivo4))}")
  end

  @doc """
  Encuentra una combinación de números que sume exactamente el objetivo.
  Retorna la combinación encontrada o {:error, :sin_solucion}.
  """
  def suma_objetivo(lista, objetivo) do
    suma_objetivo_aux(lista, objetivo, [])
  end

  # Función auxiliar recursiva
  defp suma_objetivo_aux([], 0, combinacion), do: combinacion
  defp suma_objetivo_aux([], _objetivo, _combinacion), do: {:error, :sin_solucion}

  defp suma_objetivo_aux([head | tail], objetivo, combinacion) when objetivo < 0 do
    {:error, :sin_solucion}
  end

  defp suma_objetivo_aux([head | tail], objetivo, combinacion) do
    # Opción 1: INCLUIR el elemento actual
    incluir = suma_objetivo_aux(tail, objetivo - head, [head | combinacion])

    case incluir do
      {:error, :sin_solucion} ->
        # Opción 2: EXCLUIR el elemento actual
        suma_objetivo_aux(tail, objetivo, combinacion)
      resultado ->
        resultado
    end
  end
end

Main.main()
