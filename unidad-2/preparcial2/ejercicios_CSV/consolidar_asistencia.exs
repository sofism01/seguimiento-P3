defmodule Asistencia do
  @moduledoc """
  Estructura para representar la asistencia de un estudiante en una clase.
  """
  defstruct estudiante: "", fecha: "", estado: "" # estado puede ser "P", "T", "A"

  @doc """
  Crea una nueva entrada de asistencia.
  """
  def crear(estudiante, fecha, estado) do
    %Asistencia{estudiante: estudiante, fecha: fecha, estado: estado}
  end
end

defmodule ResumenAsistencia do
  @moduledoc """
  Estructura para representar el resumen consolidado de asistencia por estudiante.
  """
  defstruct estudiante: "", total_P: 0, total_T: 0, total_A: 0
end

defmodule Main do
  @moduledoc """
  Módulo principal para consolidar la asistencia de estudiantes.
  """

  def main do

    a1 = Asistencia.crear("E001", "2023-09-01", "P")
    a2 = Asistencia.crear("E002", "2023-09-01", "A")
    a3 = Asistencia.crear("E003", "2023-09-01", "T")
    a4 = Asistencia.crear("E001", "2023-09-02", "T")
    a5 = Asistencia.crear("E002", "2023-09-02", "P")
    a6 = Asistencia.crear("E001", "2023-09-03", "A")

    asistencias = [a1, a2, a3, a4, a5, a6]

    escribir_csv(asistencias, "asistencia.csv")

    asistencias_leidas = leer_csv("asistencia.csv")

    resumen = consolidar_asistencias(asistencias_leidas)

    escribir_resumen_csv(resumen, "resumen_asistencia.csv")

  end

  @doc """
  Lee asistencias desde un archivo CSV.
  """
  def leer_csv(nombre_archivo) do
    case File.read(nombre_archivo) do
      {:ok, contenido} ->
        String.split(contenido, "\n")
        |> Enum.map(&String.trim/1)
        |> Enum.filter(fn line -> line != "" end)
        |> Enum.map(fn line ->
          case String.split(line, ",") do
            ["fecha", "estudiante", "estado"] -> nil # ignorar headers
            [fecha, estudiante, estado] ->
              estado_trimmed = String.trim(estado)
              if estado_trimmed in ["P", "T", "A"] do
                %Asistencia{
                  fecha: String.trim(fecha),
                  estudiante: String.trim(estudiante),
                  estado: estado_trimmed
                }
              else
                nil
              end
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
  Consolida las asistencias agrupando por estudiante y contando P, T, A.
  """
  def consolidar_asistencias(asistencias) do
    # Agrupar por estudiante
    asistencias_por_estudiante = Enum.group_by(asistencias, fn asistencia ->
      asistencia.estudiante
    end)

    # Calcular totales para cada estudiante
    Enum.map(asistencias_por_estudiante, fn {estudiante, registros} ->
      total_P = Enum.count(registros, fn r -> r.estado == "P" end)
      total_T = Enum.count(registros, fn r -> r.estado == "T" end)
      total_A = Enum.count(registros, fn r -> r.estado == "A" end)

      %ResumenAsistencia{
        estudiante: estudiante,
        total_P: total_P,
        total_T: total_T,
        total_A: total_A
      }
    end)
    |> Enum.sort_by(fn resumen -> resumen.estudiante end)
  end

  @doc """
  Escribe asistencias individuales a CSV.
  """
  def escribir_csv(asistencias, nombre_archivo) do
    headers = "fecha, estudiante, estado\n"

    contenido = Enum.map(asistencias, fn %Asistencia{fecha: fecha, estudiante: estudiante, estado: estado} ->
      "#{fecha}, #{estudiante}, #{estado}\n"
    end)
    |> Enum.join()

    File.write(nombre_archivo, headers <> contenido)
  end

  @doc """
  Escribe el resumen consolidado a CSV.
  """
  def escribir_resumen_csv(resumenes, nombre_archivo) do
    headers = "estudiante,total_P,total_T,total_A\n"

    contenido = Enum.map(resumenes, fn %ResumenAsistencia{estudiante: estudiante, total_P: total_P, total_T: total_T, total_A: total_A} ->
      "#{estudiante},#{total_P},#{total_T},#{total_A}\n"
    end)
    |> Enum.join()

    File.write(nombre_archivo, headers <> contenido)
  end
end

Main.main()
