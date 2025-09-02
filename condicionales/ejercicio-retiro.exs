
defmodule Main do

def main do
saldo = Util.input("Ingrese el saldo de su cuenta: ", :float)
monto = Util.input("Ingrese el monto a retirar: ", :float)
retirar(saldo, monto)

end

def retirar(saldo, monto) do
  if saldo >= monto do
    nuevo_saldo = saldo - monto
    Util.show_message("Retiro aprobado. Nuevo saldo: $#{Float.round(nuevo_saldo, 2)}")else
    Util.show_message("Fondos insuficintes")
end

end

end

Main.main()
