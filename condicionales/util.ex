
defmodule Util do
  @moduledoc """
  Módulo para manejar entrada y salida de datos con clausulas y guardas.
  """

  @doc """
  Muestra un mensaje en la consola.
  """
  def show_message(message) do
    message
    |> IO.puts()
  end

  @doc """
  Solicita y lee una entrada de datos desde la consola.
  """
  def input(message, :string) do
    message
    |> IO.gets()
    |>String.trim()
  end

  def input(message, :integer) do
    message
    |> input(:string)
    |> String.to_integer()
  end

  def input(message, :float) do
    message
    |> input(:string)
    |> String.to_float()
  end

end
