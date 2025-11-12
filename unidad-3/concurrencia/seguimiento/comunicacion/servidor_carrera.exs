defmodule Car do
  @moduledoc """
  Estructura para representar un auto en la carrera.
  """
  defstruct [:id, :piloto, :pit_ms, :vuelta_ms]
end

defmodule CarreraServidor do
  @moduledoc """
  Módulo servidor que procesa las simulaciones de carrera de autos.
  """
  @nombre_servicio_local :servicio_carrera
  @vueltas 3

  @doc """
  Función principal que inicia el proceso servidor.
  """
  def main() do
    IO.puts("SERVIDOR DE CARRERA INICIADO")
    IO.puts("Nodo: #{Node.self()}")
    registrar_servicio(@nombre_servicio_local)
    procesar_simulaciones()
  end

  # Funciones privadas

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp procesar_simulaciones() do
    receive do
      {cliente, {:simular_auto, auto}} ->
        resultado = simular_carrera(auto)
        send(cliente, resultado)
        procesar_simulaciones()

      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor terminando...")
    end
  end

  defp simular_carrera(%Car{piloto: piloto, vuelta_ms: vms, pit_ms: pms}) do
    total =
      Enum.reduce(1..@vueltas, 0, fn _, acc ->
        :timer.sleep(vms)
        acc + vms
      end)

    total_total = total + pms
    IO.puts("#{piloto} terminó con #{total_total} ms.")
    {piloto, total_total}
  end
end

CarreraServidor.main()
