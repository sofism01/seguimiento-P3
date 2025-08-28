
defmodule Main do
  @moduledoc """
  Módulo principal para ejecutar el programa.
  """

  @doc """
  Función principal que inicia el flujo del programa.
  """
  def main do
  pedir_texto()
  pedir_numero()
  pedir_decimal()
  end


@doc """
  Solicita al usuario que ingrese su nombre y lo retorna.
  """
def pedir_texto() do
"Ingrese su nombre: "
|> Util.input(:string)
|> Util.show_message()
end

@doc """
  Solicita al usuario que ingrese un número entero y muestra si es entero.
  """
def pedir_numero() do
  x = Util.input("Ingrese un numero: ", :integer)

  "El numero ingresado es entero: #{is_integer(x)}" #interpolacion
  |> Util.show_message()
  end


  def pedir_decimal() do
    x = Util.input("Ingrese un numero decimal: ", :float)

    "El numero ingresado es decimal: #{is_float(x)}" #interpolacion
    |> Util.show_message()
    end


end

#Aridad es el numero de parametros que recibe una funcion
#Clausula es el numero de definiciones que tiene una funcion, cuando tiene mismo nombre y misma aridad
#La diferencia entre ambas es su patron

Main.main()
