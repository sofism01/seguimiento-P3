
defmodule Ejercicio2 do
  @moduledoc """
  Módulo para contar caracteres de un texto ingresado.
  """

  @doc """
  Ejecuta el ejercicio solicitando un texto y mostrando la cantidad de caracteres del texto ingresado.
  """
  def ejercicio() do
    Util2.input_data("Ingrese el texto: ")
    |>String.replace(" ", "")
    |>String.length()
    |>Integer.to_string()
    |> Util2.show_message()
  end
end
Ejercicio2.ejercicio()
