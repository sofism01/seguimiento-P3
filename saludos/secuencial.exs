defmodule Secuencial do #Modulo -> UpperCamelCase

#Funcion publica -> snake_case
def mostrar_mensaje() do
  "Mensaje desde funcion"
  |> IO.puts()
end

 #Funcion de una sola linea -> snake_case
def mostrar_mensaje_unalinea(), do: IO.puts("Hola")

#Funcion privada -> snake_case
defp mostrar_mensaje_privado(mensaje) do
  mensaje
  |> IO.puts()
end

def invocacion_privado() do
  "Mensaje privado desde una funcion"
  |> mostrar_mensaje_privado()
end
end

Secuencial.invocacion_privado()
Secuencial.mostrar_mensaje()
Secuencial.mostrar_mensaje_unalinea()
Util.mostrar_mensaje("Hola Mundo")
#(condicion) ? true : false
