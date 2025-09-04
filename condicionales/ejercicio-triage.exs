defmodule Main do
  @doc """
    Programa para definir la atención en un hospital basado en el código de triage.
    """

  def main do

  codigo = Util.input("Ingrese el código de triage (rojo, amarillo, verde): ", :string)
  codigo_triage(codigo)


  end

  @doc """
    Función para definir la atención basada en el código de triage.
    """
  def codigo_triage(codigo) do
    case codigo do
      "rojo" -> Util.show_message("Atención inmediata")
      "amarillo" -> Util.show_message("Atención en 30 minutos")
      "verde" -> Util.show_message("Atención en 60 minutos")
      _ -> Util.show_message("Código inválido")
    end
  end

end

Main.main()
