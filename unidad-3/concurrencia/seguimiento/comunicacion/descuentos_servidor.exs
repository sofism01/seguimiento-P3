defmodule Carrito do # elixir --sname descuentos descuentos_servidor.exs -> para ejecutar el servidor
  @moduledoc """
  Estructura para representar un carrito de compras.
  """
  defstruct [:id, :items, :cupon]
end

defmodule DescuentosServidor do
  @moduledoc """
  Módulo servidor que procesa la aplicación de descuentos a carritos.
  """
  @nombre_servicio_local :servicio_descuentos

  @doc """
  Función principal que inicia el proceso servidor.
  """
  def main() do
    IO.puts("SERVIDOR DE DESCUENTOS DE CARRITOS INICIADO")
    IO.puts("Nodo: #{Node.self()}")
    registrar_servicio(@nombre_servicio_local)
    procesar_carritos()
  end

  # Funciones privadas

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp procesar_carritos() do
    receive do
      {cliente, {:aplicar_descuento, carrito}} ->
        resultado = total_con_descuentos(carrito)
        send(cliente, resultado)
        procesar_carritos()

      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor de descuentos terminando...")
    end
  end

  defp total_con_descuentos(%Carrito{id: id, items: items, cupon: cupon}) do
    :timer.sleep(Enum.random(5..15))

    total = Enum.sum(items)
    descuento = if cupon, do: 0.9, else: 1.0
    total_final = total * descuento

    # Mostrar resultado en servidor
    descuento_texto = if cupon, do: "10% descuento", else: "sin descuento"
    IO.puts("#{id}: $#{total} → $#{total_final} (#{descuento_texto})")

    {id, total_final}
  end
end

DescuentosServidor.main()
