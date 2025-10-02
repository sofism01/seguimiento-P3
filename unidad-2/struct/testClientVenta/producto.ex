defmodule Producto do
  @moduledoc """
  Módulo que define la estructura de un producto.
  """
  defstruct nombre: "", precio: 0.0

  @doc """
  Crea un nuevo producto.
  """
  def crear(nombre, precio) do
    %Producto{nombre: nombre, precio: precio}
  end
end
