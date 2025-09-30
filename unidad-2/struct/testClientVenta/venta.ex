defmodule Venta do
  @moduledoc """
  Módulo que define la estructura de una venta.
  """
  defstruct cliente: %Cliente{}, detalles: []

  def calcular_total(%Venta{detalles: detalles}) do
    Enum.reduce(detalles, 0, fn detalle, acc ->
      acc + Detalle.calcular_subtotal(detalle)
    end)
  end
end
