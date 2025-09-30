defmodule User do
  @moduledoc """
  Módulo que define la estructura de un usuario.
  """

  defstruct name: "none", password: nil

  @doc """
  Crea un nuevo usuario con el nombre y la contraseña proporcionados.
  """
  def crear(name, password) do
    u1 = %User{name: name, password: password}
  end

  @doc """
  Obtiene el nombre del usuario.
  """
  def obtener(%User{name: name}) do
    u1.name
  end

  @doc """
  Modifica el nombre del usuario.
  """
  def modificar(%User{} = user, new_name) do
    u2 = %User{user | name: "Sofi"}
  end

end
