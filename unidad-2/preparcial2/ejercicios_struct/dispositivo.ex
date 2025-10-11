defmodule Dispositivo do
  @moduledoc """
  Estructura para representar un dispositivo con id, tipo, marca y estado.
  """
  defstruct id: "", tipo: "", marca: "", estado: :apagado

  @doc """
  Verifica si un dispositivo es apto para préstamo.
  Un dispositivo es apto si su estado es :nuevo o :usado.
  """
  def es_apto?(%Dispositivo{estado: :nuevo}), do: true
  def es_apto?(%Dispositivo{estado: :usado}), do: true
  def es_apto?(%Dispositivo{}), do: false

  @doc """
  Actualiza el estado del dispositivo.
  Retorna una nueva instancia con el estado actualizado.
  """
  def actualizar_estado(%Dispositivo{} = dispositivo, nuevo_estado) when nuevo_estado in [:nuevo, :usado, :dañado, :apagado] do
    %{dispositivo | estado: nuevo_estado}
  end

  def actualizar_estado(%Dispositivo{}, estado_invalido) do
    {:error, "Estado inválido: #{estado_invalido}. Estados válidos: [:nuevo, :usado, :dañado]"}
  end

  @doc """
  Crea un nuevo dispositivo con los datos proporcionados.
  """
  def crear(id, tipo, marca, estado) do
    %Dispositivo{
      id: id,
      tipo: tipo,
      marca: marca,
      estado: estado
    }
  end

  @doc """
  Función para mostrar información del dispositivo.
  """
  def mostrar_info(%Dispositivo{id: id, tipo: tipo, marca: marca, estado: estado}) do
    apto = if es_apto?(%Dispositivo{estado: estado}), do: "Sí", else: "No"

    """
    ID: #{id}
    Tipo: #{tipo}
    Marca: #{marca}
    Estado: #{estado}
    Apto para préstamo: #{apto}
    """
  end
end
