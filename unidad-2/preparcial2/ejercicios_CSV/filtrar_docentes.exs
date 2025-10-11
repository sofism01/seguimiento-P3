defmodule Docente do
  @moduledoc """
  Estructura para representar un docente.
  """
  defstruct id: "", nombre: "", categoria: ""

  @doc """
  Crea un nuevo docente.
  """
  def crear(id, nombre, categoria) do
    %Docente{id: id, nombre: nombre, categoria: categoria}
  end

end

defmodule Main do
  def main do
   d1 = Docente.crear("D001", "Juan Pérez", "Titular")
   d2 = Docente.crear("D002", "María López", "Asistente")
   d3 = Docente.crear("D003", "Carlos Ruiz", "Titular")
   d4 = Docente.crear("D004", "Ana García", "Asociado")
   d5 = Docente.crear("D005", "Luis Martín", "Titular")

    docentes = [d1, d2, d3, d4, d5]

    escribir_csv(docentes, "docentes.csv")
    docentes_leidos = leer_csv("docentes.csv")
    titulares = filtrar_titulares(docentes_leidos)
    escribir_csv(titulares, "docentes_titulares.csv")
  end

  @doc """
  Lee una lista de docentes desde un archivo CSV.
  """
  def leer_csv(nombre_archivo) do
    case File.read(nombre_archivo) do
      {:ok, contenido} ->
        String.split(contenido, "\n")
        |> Enum.map(&String.trim/1)
        |> Enum.filter(fn line -> line != "" end)
        |> Enum.map(fn line ->
          case String.split(line, ",") do
            ["id", "nombre", "categoria"] -> nil # ignorar headers
            [id, nombre, categoria] ->
              %Docente{
                id: String.trim(id),
                nombre: String.trim(nombre),
                categoria: String.trim(categoria)
              }
            _ -> nil
          end
        end)
        |> Enum.filter(&(&1 != nil))

      {:error, reason} ->
        IO.puts("Error al leer el archivo: #{reason}")
        []
    end
  end

  @doc """
  Filtra solo los docentes cuya categoría sea "Titular".
  """
  def filtrar_titulares(docentes) do
    Enum.filter(docentes, fn docente ->
      docente.categoria == "Titular"
    end)
  end

  @doc """
  Escribe una lista de docentes en un archivo CSV.
  """
  def escribir_csv(list_docentes, nombre_archivo) do
    headers = "id, nombre, categoria\n"

    contenido =
      Enum.map(list_docentes, fn %Docente{id: id, nombre: nombre, categoria: categoria} ->
        "#{id}, #{nombre}, #{categoria}\n"
      end)
      |> Enum.join()

    File.write(nombre_archivo, headers <> contenido)
  end

end

Main.main()
