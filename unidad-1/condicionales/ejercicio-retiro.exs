
defmodule Main do
@doc """
  Programa para simular un retiro bancario con condicionales.
  """

def main do
saldo = Util.input("Ingrese el saldo de su cuenta (con decimales): ", :float)
monto = Util.input("Ingrese el monto a retirar (con decimales): ", :float)
retirar(saldo, monto)

end

@doc """
  Función para procesar el retiro basado en el saldo y monto solicitado.
  """
def retirar(saldo, monto) do
  if saldo >= monto do
    nuevo_saldo = saldo - monto
    Util.show_message("Retiro aprobado. Nuevo saldo: $#{Float.round(nuevo_saldo, 2)}")else
    Util.show_message("Fondos insuficintes")
end

end

end

Main.main()
