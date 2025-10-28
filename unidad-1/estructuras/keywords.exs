defmodule Main do
  @moduledoc """
  Módulo para demostrar el uso de listas en Elixir.
  """

  def main do

    crear_kw()
    obtener_valor_kw()
    agregar_clave()
    obtener_valores_kw()
    iterar_kw()

  end

  @doc """
  Crea una lista de palabras clave y muestra su contenido.
  """
  def crear_kw() do
    list_kw = [nombre: "Arroz", precio: 2500, stock: "20"]
    Util.show_message("Producto: #{inspect(list_kw)}")
  end

  @doc """
  Obtiene el valor asociado a una clave específica en una lista de palabras clave.
  """
  def obtener_valor_kw() do
    list_kw = [nombre: "Camisa", precio: 40000, stock: "12"]
    Util.show_message("Producto: #{inspect(list_kw)}")
    precio = Keyword.get(list_kw, :precio)
    Util.show_message("Precio del producto: #{precio}")
  end

  @doc """
  Agrega una nueva clave-valor a una lista de palabras clave y muestra el resultado.
  """
  def agregar_clave() do
    list_kw = [nombre: "Camisa", precio: 40000, stock: "12"]
    new_list_kw = Keyword.put(list_kw, :color, "Azul")
    Util.show_message("Producto con nueva clave: #{inspect(new_list_kw)}")
  end

  @doc """
  Obtiene todos los valores asociados a una clave específica en una lista de palabras clave.
  """
  def obtener_valores_kw() do
    list_kw = [modo: "Rapido", modo: "Seguro", tiempo: 15]
    Keyword.get_values(list_kw, :modo)
    |> Util.show_message()
  end

  @doc """
  Itera sobre una lista de palabras clave e imprime cada par clave-valor.
  """
  def iterar_kw() do
    list_kw = [usuario: "Carlos", activo: true, rol: "admin"]
    Enum.each(list_kw, fn {clave, valor} ->
    Util.show_message("#{clave}: #{valor}")
    end)
  end

end

Main.main()
