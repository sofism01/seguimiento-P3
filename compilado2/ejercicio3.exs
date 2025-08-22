
defmodule Ejercicio3 do
  @moduledoc """
  Calcula el salario neto de un empleado basado en horas trabajadas y valor por hora.
  """

  @doc """
  Ejecuta el ejercicio solicitando el nombre del empleado, horas trabajadas y valor por hora,
  calcula el salario neto y muestra un mensaje con el resultado.
  """

def ejercicio() do
    nombre = Util2.input_data("Nombre del empleado:")
    horas_str = Util2.input_data("Horas trabajadas:")
    valor_str = Util2.input_data("Valor por hora:")

    horas = String.to_integer(horas_str)
    valor = String.to_integer(valor_str)

    base = min(horas, 160) * valor
    extra = if horas > 160, do: (horas - 160) * valor * 1.25, else: 0.0
    salario = base + extra

    mensaje = "El salario neto de #{nombre} es $#{:erlang.float_to_binary(salario, decimals: 2)}"
    Util2.show_message(mensaje)
  end
end

Ejercicio3.ejercicio()
