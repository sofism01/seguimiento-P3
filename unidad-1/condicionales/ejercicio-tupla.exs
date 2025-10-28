defmodule Main do
@doc """
  Programa para ubicar un punto en el plano cartesiano usando tuplas y condicionales.
  """

def main do

  punto = {Util.input("Ingrese la coordenada X del punto (entero): ", :integer),
           Util.input("Ingrese la coordenada Y del punto (entero): ", :integer)}
  ubicar_punto(punto)

end

@doc """
  Función para ubicar el punto basado en sus coordenadas.
  """
def ubicar_punto({x, y}) do
  cond do
   x == 0 and y ==0 -> Util.show_message("El punto está en el origen")
   x == 0 -> Util.show_message("El punto está sobre el eje Y")
   y == 0 -> Util.show_message("El punto está sobre el eje X")
   true -> Util.show_message("El punto está en el plano cartesiano")
  end

end

end

Main.main()
