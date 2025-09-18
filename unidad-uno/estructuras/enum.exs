defmodule Main do
  @moduledoc """
  Módulo para demostrar el uso de Enum en Elixir
  """

  def main do

    imprimir_numeros()
    lista_cuadrados()
    obtener_pares()
    sumar_elementos()
    agrupar_por_edad()

  end

  @doc """
  Imprime todos los valores de la lista
  """
  def imprimir_numeros do
    lista = [1, 2, 3, 4, 5]
    Enum.each(lista, fn x -> IO.puts x end)
  end

  @doc """
  Dada una lista muestra una nueva con los cuadrados de los elementos
  """
  def lista_cuadrados do
    lista = [1, 2, 3, 4]
    Util.show_message("Lista original: #{inspect(lista)}")
    lista2 = Enum.map(lista, fn x -> x**2  end)
    Util.show_message("Lista con sus cuadrados: #{inspect(lista2)}")
  end

  @doc """
  Dada una lista retorna una nueva solo con los numeros pares
  """
  def obtener_pares do
    lista = [5, 6, 7, 8, 9, 10]
    Util.show_message("Lista original: #{inspect(lista)}")
    pares = Enum.filter(lista, fn x -> rem(x, 2) == 0 end)
    Util.show_message("Números pares: #{inspect(pares)}")
  end

  @doc """
  Suma los elementos de una lista
  """
  def sumar_elementos do
    lista = [10, 20, 30]
    Util.show_message("Lista de numeros: #{inspect(lista)}")
    suma = Enum.reduce(lista, &+/2)
    Util.show_message("Lista de los elementos sumados es: #{inspect(suma)}")
  end

  @doc """
  Agrupa las personas por edad
  """
  def agrupar_por_edad do
    personas = [
      %{nombre: "Anna", edad: 20},
      %{nombre: "Juan", edad: 25},
      %{nombre: "Luis", edad: 20}
    ]
    Util.show_message("Lista de personas: #{inspect(personas)}")
    filtro = Enum.group_by(personas, fn persona -> persona.edad end)
    Util.show_message("Personas filtradas por edad: #{inspect(filtro)}")
  end

end

Main.main()
