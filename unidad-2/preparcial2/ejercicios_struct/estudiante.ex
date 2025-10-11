defmodule Estudiante do
  @moduledoc """
  Estructura para representar un estudiante con id, nombre, email y semestre.
  """
  defstruct id: "", nombre: "", email: "", semestre: 0

  @doc """
  Promueve el semestre del estudiante en +1.
  Retorna una nueva instancia con el semestre incrementado.
  """
  def promover_semestre(%Estudiante{} = estudiante) do
    %{estudiante | semestre: estudiante.semestre + 1}
  end

  @doc """
  Valida si el correo pertenece al dominio institucional (@uq.edu.co).
  Retorna true si es válido, false en caso contrario.
  """
  def validar_email_institucional(%Estudiante{email: email}) do
    String.ends_with?(email, "@uq.edu.co")
  end

  @doc """
  Crea un nuevo estudiante con los datos proporcionados.
  """
  def crear(id, nombre, email, semestre \\ 1) do
    %Estudiante{
      id: id,
      nombre: nombre,
      email: email,
      semestre: semestre
    }
  end

  @doc """
  Función para mostrar información del estudiante.
  """
  def mostrar_info(%Estudiante{id: id, nombre: nombre, email: email, semestre: semestre}) do
    email_valido = if validar_email_institucional(%Estudiante{email: email}), do: "Válido", else: "Inválido"

    """
    ID: #{id}
    Nombre: #{nombre}
    Email: #{email} (#{email_valido})
    Semestre: #{semestre}
    """
  end

end
