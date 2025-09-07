defmodule Main do
  @moduledoc """
  Módulo para demostrar el uso de tuplas en Elixir.
  """

def main do

  definir_tupla()
  actualizar_tupla()
  a = Util.input("Ingrese el dividendo: ", :integer)
  b = Util.input("Ingrese el divisor: ", :integer)
  division_tupla(a, b)
  pattern_matching_tupla()
  convertir_tupla()

end

@doc """
  Define una tupla, muestra su contenido y accede a un elemento específico.
  """
def definir_tupla do
  tupla = {:ok, "Elixir", 2024}
  Util.show_message("La tupla es: #{inspect(tupla)}")
  elemento2 = elem(tupla, 1)
  Util.show_message("El segundo elemento de la tupla es: #{elemento2}")
end

@doc """
  Actualiza un elemento de la tupla y muestra la tupla actualizada.
  """
def actualizar_tupla do
  tupla = {:ok, "Exitoso", 200}
  Util.show_message("Tupla original: #{inspect(tupla)}")
  nueva_tupla = put_elem(tupla, 2, 404)
  Util.show_message("Tupla actualizada: #{inspect(nueva_tupla)}")
end

@doc """
  Realiza una división segura utilizando tuplas para manejar errores.
  """
def division_tupla(a, b) do
  if b != 0 do
    resultado = a / b
   Util.show_message("{:ok, #{resultado}}")
  else
  Util.show_message(inspect({:error, "División por cero no permitida"}))
  end
end

@doc """
  Demuestra el uso de pattern matching con tuplas.
  """
def pattern_matching_tupla do
  {:usuario, nombre, edad} = {:usuario, "Anna", 25}
  IO.puts(nombre)
  IO.puts(edad)
end

@doc """
  Convierte una tupla en una lista y muestra la lista resultante.
  """
def convertir_tupla do
  tupla = {:a, :b, :c}
  Util.show_message("La tupla es: #{inspect(tupla)}")
  lista = Tuple.to_list(tupla)
  IO.inspect(lista)
end

end

Main.main()
