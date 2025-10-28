defmodule Ejercicio1 do
  @moduledoc """
  Recibe un mensaje y lo retorna en mayúsculas.
  """

@doc"""
  Ejecuta el ejercicio solicitando un texto, lo convierte a mayusculas y muestra un mensaje.
  """
  def ejercicio do
txt =  Util2.input_data("Ingrese un texto: ")
  |> String.upcase()
  |> Util2.show_message()
  end
end

Ejercicio1.ejercicio()
