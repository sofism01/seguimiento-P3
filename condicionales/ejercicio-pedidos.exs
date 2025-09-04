defmodule Main do
  @doc """
  Programa para gestionar pedidos con condicionales.
  """

  def main do

  Util.input("Ingrese el estado de su pedido (en curso, entregado): ", :string)
  |> definir_entrega()

  end

  @doc """
  Función para definir la entrega de un pedido basado en su estado.
  """
  def definir_entrega(estado)do
    unless estado == "en curso" do
      Util.show_message("Asignando nuevo pedido")
    else
      Util.show_message("No puede tomar un nuevo pedido hasta entregar el actual")
    end
  end

end

Main.main()
