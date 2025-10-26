defmodule Cliente do
  @moduledoc """
  Estructura para representar un cliente.
  """
  defstruct id: "", nombre: "", correo: ""

  @doc """
  Crea un nuevo cliente.
  """
  def crear(id, nombre, correo) do
    %Cliente{id: id, nombre: nombre, correo: correo}
  end

  @doc """
  Normaliza un cliente: nombre en título y correo en minúsculas.
  """
  def normalizar(%Cliente{id: id, nombre: nombre, correo: correo}) do
    %Cliente{
      id: id,
      nombre: normalizar_titulo(nombre),
      correo: String.downcase(correo)
    }
  end

  @doc """
  Convierte un texto a formato título (primera letra de cada palabra en mayúscula).
  """
  defp normalizar_titulo(texto) do
    String.split(texto, " ")
    |> Enum.map(fn palabra ->
      case String.length(palabra) do
        0 -> palabra
        _ -> String.capitalize(palabra)
      end
    end)
    |> Enum.join(" ")
  end
end

defmodule Main do
  def main do
    # Crear datos de prueba con diferentes formatos
    crear_datos_prueba()

    # Leer clientes desde CSV
    clientes = leer_csv("clientes.csv")

    # Normalizar clientes
    clientes_normalizados = Enum.map(clientes, fn cliente ->
      Cliente.normalizar(cliente)
    end)

    # Escribir clientes normalizados
    escribir_csv(clientes_normalizados, "clientes_normalizado.csv")

    IO.puts("Normalización completada:")
    IO.puts("- Clientes procesados: #{length(clientes)}")
    IO.puts("- Archivo generado: clientes_normalizado.csv")

  end

  @doc """
  Crea datos de prueba con diferentes formatos de nombres y correos.
  """
  def crear_datos_prueba do
    clientes = [
      Cliente.crear("C001", "juan PEREZ rodriguez", "JUAN.PEREZ@GMAIL.COM"),
      Cliente.crear("C002", "MARIA lopez GARCIA", "Maria.Lopez@HOTMAIL.com"),
      Cliente.crear("C003", "carlos ruiz", "CARLOS.RUIZ@yahoo.COM"),
      Cliente.crear("C004", "ANA SOFIA martinez", "ana.sofia@UQ.EDU.CO"),
      Cliente.crear("C005", "luis FERNANDO castro", "LuIs.CaStRo@OUTLOOK.com")
    ]

    escribir_csv(clientes, "clientes.csv")
    IO.puts("Archivo clientes.csv creado con datos de prueba")
  end

  @doc """
  Lee clientes desde un archivo CSV.
  """
  def leer_csv(nombre_archivo) do
    case File.read(nombre_archivo) do
      {:ok, contenido} ->
        String.split(contenido, "\n")
        |> Enum.map(&String.trim/1)
        |> Enum.filter(fn line -> line != "" end)
        |> Enum.map(fn line ->
          case String.split(line, ",") do
            ["id", "nombre", "correo"] -> nil # ignorar headers
            [id, nombre, correo] ->
              %Cliente{
                id: String.trim(id),
                nombre: String.trim(nombre),
                correo: String.trim(correo)
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
  Escribe clientes a un archivo CSV.
  """
  def escribir_csv(clientes, nombre_archivo) do
    headers = "id, nombre, correo\n"

    contenido = Enum.map(clientes, fn %Cliente{id: id, nombre: nombre, correo: correo} ->
      "#{id}, #{nombre}, #{correo}\n"
    end)
    |> Enum.join()

    File.write(nombre_archivo, headers <> contenido)
  end

end

Main.main()
