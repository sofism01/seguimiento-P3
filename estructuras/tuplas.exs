defmodule Main do

def main do

  definir_tupla()
  actualizar_tupla()
  a = Util.input("Ingrese el dividendo: ", :integer)
  b = Util.input("Ingrese el divisor: ", :integer)
  division_tupla(a, b)


end

def definir_tupla do
  tupla = {:ok, "Elixir", 2024}
  elemento2 = elem(tupla, 1)
  Util.show_message("El segundo elemento de la tupla es: #{elemento2}")

end

def actualizar_tupla do

  tupla = {:ok, "Exitoso", 200}
  Util.show_message("Tupla original: #{inspect(tupla)}")
  nueva_tupla = put_elem(tupla, 2, 404)
  Util.show_message("Tupla actualizada: #{inspect(nueva_tupla)}")

end

def division_tupla(a, b) do
  if b != 0 do
   Util.show_message("{:ok, resultado}")
  else
   Util.show_message({:error, "División por cero no permitida"})
end

end

end


Main.main()
