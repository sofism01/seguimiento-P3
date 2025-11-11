defmodule Carrito do
  defstruct [:id, :items, :cupon]
end

defmodule DescuentosCarritos do
  # Cargar el módulo Benchmark
  Code.require_file("benchmark.ex", __DIR__)
  alias Benchmark, as: BenchmarkUtils

  def total_con_descuentos(%Carrito{id: id, items: items, cupon: cupon}) do
    :timer.sleep(Enum.random(5..15))

    total = Enum.sum(items)
    descuento = if cupon, do: 0.9, else: 1.0

    {id, total * descuento}
  end

  def aplicar_secuencial(carritos), do: Enum.map(carritos, &total_con_descuentos/1)
  def aplicar_concurrente(carritos) do
    carritos
    |> Enum.map(&Task.async(fn -> total_con_descuentos(&1) end))
    |> Task.await_many()
  end

  def lista_carritos do
    [
      %Carrito{id: "C1", items: [100, 50], cupon: true},
      %Carrito{id: "C2", items: [200], cupon: false},
      %Carrito{id: "C3", items: [75, 25, 30], cupon: true},
      %Carrito{id: "C4", items: [150, 80], cupon: false},
      %Carrito{id: "C5", items: [90], cupon: true}
    ]
  end

  def ejecutar_comparacion do
    carritos = lista_carritos()

    IO.puts("DESCUENTOS")
    IO.puts("Carritos: #{length(carritos)}")

    tiempo_sec = BenchmarkUtils.determinar_tiempo_ejecucion({__MODULE__, :aplicar_secuencial, [carritos]})
    tiempo_con = BenchmarkUtils.determinar_tiempo_ejecucion({__MODULE__, :aplicar_concurrente, [carritos]})
    speedup = BenchmarkUtils.calcular_speedup(tiempo_con, tiempo_sec)

    IO.puts("Secuencial: #{tiempo_sec} μs")
    IO.puts("Concurrente: #{tiempo_con} μs")
    IO.puts("Speedup: #{Float.round(speedup, 2)}x")

    BenchmarkUtils.generar_mensaje(tiempo_con, tiempo_sec) |> IO.puts()
  end
end

DescuentosCarritos.ejecutar_comparacion()
