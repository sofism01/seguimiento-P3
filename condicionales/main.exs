defmodule Main do

  def main do

Util.input("Ingrese su edad: ", :integer)
|> condicion_if()
Util.input("Ingrese su contraseña: ", :string)
|> condicion_unless()
Util.input("Ingrese un número: ", :integer)
|> numero_positivo()
Util.input("Ingrese un número: ", :integer)
|> es_cero()
Util.input("Ingrese la nota: ", :float )
|> condicion_cond()
Util.input("Ingrese una letra: ", :string)
|> condicion_case()


  end

  #Un programa que reciba la edad de una persona y muestre si es mayor de edad
  #usando el condicional if
  def condicion_if(edad) do
    if edad>=18 do
    Util.show_message("Es mayor de edad") #Aqui primero se pone la condicion verdadera
  else
    Util.show_message("No es mayor de edad")
  end
end


#Un programa que reciba una contraseña y muestre si es correcta o incorrecta (la contraseña correcta es "1234")
#usando el condicional unless
  def condicion_unless(password) do
    unless password == "1234" do
      Util.show_message("Contraseña incorrecta") #Aqui primero se pone la condicion falsa
    else
      Util.show_message("Contraseña correcta")
    end
end

#Un programa que reciba un número y muestre si es positivo o negativo usando el condicional if
def numero_positivo(n) do
  if n > 0 do
    Util.show_message("Positivo")
  else
    Util.show_message("Negativo")
  end
end

#Un programa que reciba un número y muestre si es cero o no usando el condicional unless
def es_cero(n) do
  unless n == 0 do
    Util.show_message("No es cero")
  else
    Util.show_message("El número es cero")
  end
end

#Un programa que reciba una nota (de 0 a 5) y muestre si es Excelente (nota >= 4.5), Aprobado (nota entre 3.0 y 4.5) o Reprobado (nota < 3.0)
#usando el condicional cond
def condicion_cond(nota) do
  cond do
    nota >= 4.5 -> Util.show_message("Excelente")
    nota >= 3.0 -> Util.show_message("Aprovado")
    nota < 3.0 -> Util.show_message("Reprobado")
    true -> Util.show_message("Nota inválida")
  end
end

#Un programa que reciba un carácter y muestre si es una vocal (a, e, i, o, u) o no usando el condicional case
def condicion_case(char) do
  case char do
    "a" -> Util.show_message("Vocal")
    "e" -> Util.show_message("Vocal")
    "i" -> Util.show_message("Vocal")
    "o" -> Util.show_message("Vocal")
    "u" -> Util.show_message("Vocal")
    _ -> Util.show_message("No es vocal")
  end
end

end

Main.main()
