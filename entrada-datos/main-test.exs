
defmodule Main do

def main do
  numero_positivo_negativo(1)
  |> Util.show_message()

  numero_positivo_negativo(-1)
  |> Util.show_message()

  numero_positivo_negativo(0)
  |> Util.show_message()
end

def numero_positivo_negativo(n) when (n>0), do: "Positivo" #Clausula
def numero_positivo_negativo(n) when (n<0), do: "Negativo" #Clausula
def numero_positivo_negativo(0), do: "Cero"

end

#Guardas (when) -> condiciones adicionales para una funcion

Main.main()
