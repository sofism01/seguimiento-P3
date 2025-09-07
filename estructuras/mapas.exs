defmodule Main do
  @moduledoc """
  Módulo para demostrar el uso de mapas en Elixir
  """

  def main do

    crear_mapa()
    agregar_clave()
    actualizar_mapa()
    eliminar_clave()
    recorrer_mapa()

  end

  @doc """
  Crea un mapa, obtiene el valor de ciudad y lo muestra
  """
def crear_mapa do
  mapa = %{nombre: "Sofi", edad: 18, ciudad: "Armenia"}
  Util.show_message("El mapa es: #{inspect(mapa)}")
  ciudad = Map.get(mapa, :ciudad)
  Util.show_message("La ciudad es: #{inspect(ciudad)}")
end

@doc """
Agrgar una clave y valor al mapa persona
"""
def agregar_clave do
  persona = %{nombre: "Sofi", edad: 18, ciudad: "Armenia"}
  Util.show_message("La persona es: #{inspect(persona)}")
  persona2 = Map.put(persona, :profesion, "Ingeniera")
  Util.show_message("La persona con profesion es: #{inspect(persona2)}")
end

@doc """
Actualiza el valor de la clave edad del mapa
"""
def actualizar_mapa do
  mapa = %{nombre: "Anna", edad: 25}
  Util.show_message("La persona es: #{inspect(mapa)}")
  mapa2 = %{mapa | edad: 26}
  Util.show_message("La persona actualizada es: #{inspect(mapa2)}")
end

@doc """
Elimina la clave y el valor ciudad del mapa
"""
def eliminar_clave do
  mapa = %{nombre: "Luis", edad: 30, ciudad: "Cali"}
  Util.show_message("El mapa es: #{inspect(mapa)}")
  mapa2 = Map.delete(mapa, :ciudad)
  Util.show_message("El nuevo mapa es: #{inspect(mapa2)}")
end

@doc """
Recorre el mapa y muestra sus claves y respectivos valores
"""
def recorrer_mapa do
  mapa = %{a: 1, b: 2, c: 3}
  Enum.each(mapa, fn {clave, valor} ->
  IO.puts "#{clave}: #{valor}"
end)
end

end

Main.main()
