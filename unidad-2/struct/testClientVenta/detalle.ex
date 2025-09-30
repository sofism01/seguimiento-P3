defmodule Detalle do
  @moduledoc """
  Módulo que define la estructura de un detalle de venta.
  """
  defstruct producto: nil, cantidad: 0

  def calcular_subtotal(%Detalle{producto: producto, cantidad: cantidad}) do
    producto.precio * cantidad
  end
end
