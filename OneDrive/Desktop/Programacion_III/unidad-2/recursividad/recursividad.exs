
defmodule Recursividad do

def main do

  #metodoRecursivo
  matryoshka_recursiva(5)
  matryoshka_recursiva_clausula(5)

end


# Tipos de recursividad: directa - lineal - no de cola
  def matryoshka_recursiva(n) do
    if n==0 do #Caso base
     IO.puts("No hay más muñecas para abrir.")
    else
      IO.puts("Abriendo la muñeca #{n}...")
      matryoshka_recursiva(n-1) #Llamado recursivo
      IO.puts("Cerrando la muñeca #{n}...")
    end
  end

  def matryoshka_recursiva_clausula(n) when n == 0 do #Caso base con guarda
    IO.puts("No hay más muñecas para abrir.")
  end

  def matryoshka_recursiva_clausula(n) when n > 0 do
      IO.puts("Abriendo la muñeca #{n}...")
      matryoshka_recursiva(n-1) #Llamado recursivo con guarda
      IO.puts("Cerrando la muñeca #{n}...")
  end

end

Recursividad.main()
