defmodule Main do
  @moduledoc """
  Modulo para simular configuraciones
  """

  def main do

    list_kw = definir_kw()
    agregar_clave(list_kw)
    mapa = convertir_a_mapa(list_kw)
    imprimir_mapa(mapa)

  end

  @doc """
  Crea keyword list con configuraciones, la muestra y la retorna
  """
 def definir_kw do
  list_kw = [modo: "Rapido", intentos: 3, usuario: "admin"]
  Util.show_message("Configuraciones: #{inspect(list_kw)}")
  list_kw
 end

@doc """
Agrega una clave y valor a la keyword list existente
"""
 def agregar_clave(list_kw) do
   new_list_kw = Keyword.put(list_kw, :activo, true)
   Util.show_message("Configuraciones con nueva clave: #{inspect(new_list_kw)}")
   new_list_kw
 end

 @doc """
Convierte la keyword list en un mapa
 """
 def convertir_a_mapa(new_list_kw) do
  mapa = Map.new(new_list_kw)
  Util.show_message("Mapa: #{inspect(mapa)}")
  mapa
 end

 @doc """
 Imprime clave-valor del mapa
 """
 def imprimir_mapa(mapa) do
 Enum.each(mapa, fn {clave, valor} ->
  IO.puts "#{clave}: #{valor}"
end)
end

end

Main.main()
