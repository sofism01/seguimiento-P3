defmodule Orden do #  elixir --sname cocina cocina_servidor.exs -> para ejecutar el servidor
  @moduledoc """
  Estructura para representar una orden de bebida/comida en la cafetería.
  """
  defstruct [:id, :item, :prep_ms]
end

defmodule CocinaServidor do
  @moduledoc """
  Módulo servidor que procesa la preparación de órdenes de cafetería.
  """
  @nombre_servicio_local :servicio_cocina
  @vueltas 3

  @doc """
  Función principal que inicia el proceso servidor.
  """
  def main() do
    IO.puts("SERVIDOR DE COCINA INICIADO")
    IO.puts("Nodo: #{Node.self()}")
    registrar_servicio(@nombre_servicio_local)
    procesar_ordenes()
  end

  # Funciones privadas

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp procesar_ordenes() do
    receive do
      {cliente, {:preparar_orden, orden}} ->
        resultado = preparar(orden)
        send(cliente, resultado)
        procesar_ordenes()

      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor de cocina terminando...")
    end
  end

  defp preparar(%Orden{id: id, item: item, prep_ms: tiempo}) do
    total_prep =
      Enum.reduce(1..@vueltas, 0, fn paso, acc ->
        :timer.sleep(tiempo)
        IO.puts("Orden #{id} (#{item}) - Paso #{paso}/#{@vueltas}")
        acc + tiempo
      end)

    ticket = "TICKET-#{id}: #{item} - Listo en #{total_prep}ms"
    IO.puts("#{ticket}")
    {id, item, ticket, total_prep}
  end
end

CocinaServidor.main()
