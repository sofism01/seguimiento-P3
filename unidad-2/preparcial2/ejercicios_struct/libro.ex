defmodule Libro do
  @moduledoc """
  Estructura para representar un libro con isbn, titulo, autor, anio, prestado.
  """
  defstruct isbn: "", titulo: "", autor: "", anio: 0, prestado: false

    @doc """
  Marca un libro como prestado.
  Retorna una nueva instancia del libro marcado como prestado.
  """
  def prestar(%Libro{} = libro) do
    %{libro | prestado: true}
  end

  @doc """
  Marca un libro como devuelto.
  Retorna una nueva instancia del libro marcado como no prestado.
  """
  def devolver(%Libro{} = libro) do
    %{libro | prestado: false}
  end

  @doc """
  Crea un nuevo libro con los datos proporcionados.
  """
  def crear(isbn, titulo, autor, anio, prestado \\ false) do
    %Libro{
      isbn: isbn,
      titulo: titulo,
      autor: autor,
      anio: anio,
      prestado: prestado
    }
  end

  @doc """
  Verifica si un libro está disponible (no prestado).
  """
  def disponible?(%Libro{prestado: prestado}), do: not prestado

  @doc """
  Función para mostrar información del libro.
  """
  def mostrar_info(%Libro{isbn: isbn, titulo: titulo, autor: autor, anio: anio, prestado: prestado}) do
    estado = if prestado, do: "Prestado", else: "Disponible"

    """
    ISBN: #{isbn}
    Título: #{titulo}
    Autor: #{autor}
    Año: #{anio}
    Estado: #{estado}
    """
  end
  
end
