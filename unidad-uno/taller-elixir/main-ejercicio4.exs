
defmodule SalarioEmpleado do
  @doc """
  Calcula el salario total de un empleado, solicitando nombre, salario base y horas extras.
  Muestra el resultado utilizando un programa Java externo.
  """

  @doc """
  Ejecuta el cálculo del salario.
  """
  def calcular do
    nombre = UtilTest.input("Ingrese el nombre del empleado: ", :string)

    salario_base =
      try do
        UtilTest.input("Ingrese el salario base: ", :float)
      rescue
        _ ->
          UtilTest.input("Valor inválido. Ingrese el salario base (número con decimales): ", :float)
      end

    horas_extras =
      try do
        UtilTest.input("Ingrese el número de horas extras trabajadas: ", :integer)
      rescue
        _ ->
          UtilTest.input("Valor inválido. Ingrese el número de horas extras (número entero): ", :integer)
      end

    valor_hora = salario_base / 160
    pago_extras = horas_extras * valor_hora * 1.5
    salario_total = salario_base + pago_extras

    mensaje = "Empleado: #{nombre}\nSalario base: $#{Float.round(salario_base, 2)}\nHoras extras: #{horas_extras}\nSalario total: $#{Float.round(salario_total, 2)}"
    System.cmd("java", ["-cp", ".", "Mensaje", mensaje])
  end
end

SalarioEmpleado.calcular()
