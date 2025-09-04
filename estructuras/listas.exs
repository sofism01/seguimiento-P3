defmodule Main do

def main do
lista_ciudades()
Util.show_message("Lista de ciudades: #{inspect(lista_ciudades())}")
concatenar_listas()
Util.show_message("Lista concatenada: #{inspect(concatenar_listas())}")
restar_listas()
Util.show_message("Lista restada: #{inspect(restar_listas())}")

end

def lista_ciudades do
  ciudades = ["Bogotá", "Medellín", "Cali", "Barranquilla", "Cartagena"]

end

def concatenar_listas do
  lista1 = [1, 2, 3]
  lista2 = [4, 5, 6]
  lista_concatenada = lista1 ++ lista2
end

def restar_listas do
  lista1 = [10, 20, 30, 40, 50]
  lista2 = [20, 50]
  lista_resta = lista1 -- lista2
end


end
Main.main()
