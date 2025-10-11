defmodule Curso do
  @moduledoc """
  Estructura para representar un curso con codigo, nombre, creditos y docente.
  """
  defstruct codigo: "", nombre: "", creditos: 0, docente: ""

  @doc """
  Valida si un curso es de alta carga (≥ 4 créditos).
  Retorna true si es de alta carga, false en caso contrario.
  """
  def validar_curso(%Curso{creditos: creditos}) when creditos >= 4, do: true
  def validar_curso(%Curso{}), do: false

  @doc """
  Cambia el docente asignado al curso.
  Retorna una nueva instancia del curso con el nuevo docente.
  """
  def cambiar_docente(%Curso{} = curso, nuevo_docente) do
    %{curso | docente: nuevo_docente}
  end

  @doc """
  Crea un nuevo curso con los datos proporcionados.
  """
  def crear(codigo, nombre, creditos, docente) do
    %Curso{
      codigo: codigo,
      nombre: nombre,
      creditos: creditos,
      docente: docente
    }

end

  @doc """
  Función para mostrar información del curso.
  """
  def mostrar_info(%Curso{codigo: codigo, nombre: nombre, creditos: creditos, docente: docente}) do
    alta_carga = if validar_curso(%Curso{creditos: creditos}), do: "Sí", else: "No"

    """
    Curso: #{codigo} - #{nombre}
    Créditos: #{creditos}
    Docente: #{docente}
    Alta carga: #{alta_carga}
    """
  end

end
