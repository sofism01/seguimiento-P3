defmodule Main do
@doc """
  Programa para definir la puntuación en un videojuego basado en la dificultad.
  """

def main do

  dificultad = Util.input("Ingrese la dificultad del enemigo: ", :integer)
  definir_puntuacion(dificultad)

end

@doc """
  Función para definir la puntuación basada en la dificultad del videojuego.
  """
def definir_puntuacion(dificultad) do
cond do
  dificultad < 3 -> Util.show_message("Puntuación: +10")
  dificultad >=3 and dificultad < 6-> Util.show_message("Puntuación: +20")
  dificultad >=6 -> Util.show_message("Puntuación: +50")
  true -> Util.show_message("Dificultad inválida")
end

end

end

Main.main()
