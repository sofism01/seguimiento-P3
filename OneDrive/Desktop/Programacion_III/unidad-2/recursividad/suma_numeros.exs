defmodule Main do

  def main do
    n = IO.gets("Ingrese un número positivo para calcular la suma hasta ese número: ")
     |> String.trim()
     |> String.to_integer()
     suma = calcular_suma(n)
     IO.puts("La suma de los números hasta #{n} es: #{suma}")

    end

  def calcular_suma(0) do #Caso base
  0
  end

  def calcular_suma(n) when n > 0 do #Llamado recursivo con guarda
    calcular_suma(n - 1) + n
end

end

Main.main()
