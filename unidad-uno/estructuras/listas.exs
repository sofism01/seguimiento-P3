defmodule Main do
  @moduledoc """
  Módulo para demostrar el uso de listas en Elixir.
  """


def main do

lista_ciudades()
concatenar_listas()
restar_listas()
multiplicar_lista()
desestructurar_lista()

end

@doc """
  Muestra una lista de ciudades.
  """
def lista_ciudades do
  ciudades = ["Bogotá", "Medellín", "Cali", "Barranquilla", "Cartagena"]
  Util.show_message("La lista de ciudades es: #{inspect(ciudades)}")
end

@doc """
  Concatena dos listas y muestra el resultado.
  """
def concatenar_listas do
  lista1 = [1, 2, 3]
  Util.show_message("La lista original es: #{inspect(lista1)}")
  lista2 = [4, 5, 6]
  Util.show_message("La lista a sumar es: #{inspect(lista2)}")
  lista_concatenada = lista1 ++ lista2
  Util.show_message("La suma de listas es: #{inspect(lista_concatenada)}")
end

@doc """
  Resta elementos de una lista y muestra el resultado.
  """
def restar_listas do
  lista1 = [10, 20, 30, 40, 50]
  Util.show_message("La lista original es: #{inspect(lista1)}")
  lista2 = [20, 50]
  Util.show_message("La lista a restar es: #{inspect(lista2)}")
  lista_resta = lista1 -- lista2
  Util.show_message("La lista restada es: #{inspect(lista_resta)}")
end

@doc """
  Multiplica cada elemento de una lista por 3 y muestra el resultado.
  """
def multiplicar_lista do
  lista1 = [3, 6, 9, 0]
  Util.show_message("La lista original es: #{inspect(lista1)}")
  lista2 = Enum.map(lista1, fn x -> x * 3 end)
  Util.show_message("La lista multiplicada por 3 es: #{inspect(lista2)}")
end

@doc """
  Desestructura una lista en su cabeza y cola, mostrando ambos.
  """
def desestructurar_lista do
  [a | b] = [100, 200, 300]
  IO.puts(a)
  IO.inspect(b)
end

end

Main.main()
