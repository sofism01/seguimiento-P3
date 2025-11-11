defmodule Review do
  @moduledoc """
  Estructura para representar una reseña de cliente.
  """
  defstruct [:id, :texto]
end

defmodule LimpiezaResenas do
  @moduledoc """
  Módulo para limpiar reseñas de clientes usando Benchmark.
  """

  # Cargar el módulo Benchmark
  Code.require_file("benchmark.ex", __DIR__)
  alias Benchmark, as: BenchmarkUtils

  # Lista de stopwords en español
  @stopwords ["el", "la", "de", "que", "y", "a", "en", "un", "es", "se", "no",
              "te", "lo", "le", "da", "su", "por", "son", "con", "para", "al",
              "del", "los", "las", "una", "muy", "mi", "me", "más", "pero", "ya"]

  @doc """
  Función que limpia una reseña completa.
  Aplica: downcase, quitar tildes, quitar stopwords + sleep aleatorio.
  """
  def limpiar(%Review{id: id, texto: texto}) do
    # Simular tiempo de procesamiento variable
    tiempo_sleep = Enum.random(5..15)
    :timer.sleep(tiempo_sleep)

    # Paso 1: Convertir a minúsculas
    texto_limpio = String.downcase(texto)

    # Paso 2: Quitar tildes y caracteres especiales
    texto_limpio = quitar_tildes(texto_limpio)

    # Paso 3: Dividir en palabras y quitar stopwords
    palabras = texto_limpio
    |> String.split(~r/[^\w]/u, trim: true)
    |> Enum.reject(fn palabra -> palabra in @stopwords end)
    |> Enum.reject(fn palabra -> String.length(palabra) < 3 end)

    # Crear resumen con las primeras 5 palabras relevantes
    resumen = palabras
    |> Enum.take(5)
    |> Enum.join(" ")

    {id, resumen}
  end

  defp quitar_tildes(texto) do
    texto
    |> String.replace("á", "a")
    |> String.replace("é", "e")
    |> String.replace("í", "i")
    |> String.replace("ó", "o")
    |> String.replace("ú", "u")
    |> String.replace("ñ", "n")
    |> String.replace("ü", "u")
    |> String.replace(~r/[^\w\s]/u, " ")
  end

  @doc """
  Limpieza secuencial de reseñas.
  """
  def limpiar_secuencial(resenas) do
    Enum.map(resenas, &limpiar/1)
  end

  @doc """
  Limpieza concurrente de reseñas.
  """
  def limpiar_concurrente(resenas) do
    resenas
    |> Enum.map(fn resena ->
      Task.async(fn -> limpiar(resena) end)
    end)
    |> Task.await_many(20000)
  end

  @doc """
  Genera reseñas de ejemplo.
  """
  def lista_resenas do
    [
      %Review{id: "R001", texto: "Este producto es muy bueno, lo recomiendo muchísimo. Excelente calidad y precio."},
      %Review{id: "R002", texto: "No me gustó para nada, llegó dañado y el servicio al cliente es pésimo."},
      %Review{id: "R003", texto: "Perfecto para lo que necesitaba. Rápida entrega y bien empaquetado."},
      %Review{id: "R004", texto: "La calidad no es la esperada por el precio que pagué. Muy decepcionante."},
      %Review{id: "R005", texto: "Increíble producto! Superó mis expectativas. Definitivamente compraré de nuevo."},
      %Review{id: "R006", texto: "Regular, ni bueno ni malo. Cumple con lo básico pero nada extraordinario."},
      %Review{id: "R007", texto: "Excelente atención y el producto llegó antes de tiempo. Muy satisfecho."},
      %Review{id: "R008", texto: "Tuve problemas con el envío pero el producto final está bien. Mejorable."}
    ]
  end

  @doc """
  Ejecuta la comparación usando Benchmark.
  """
  def ejecutar_comparacion do
    resenas = lista_resenas()

    IO.puts("LIMPIEZA DE RESEÑAS")
    IO.puts("=" |> String.duplicate(50))

    IO.puts("Reseñas a procesar: #{length(resenas)}")

    # Mostrar algunas reseñas originales
    IO.puts("Ejemplos de reseñas originales:")
    Enum.take(resenas, 3)
    |> Enum.each(fn %Review{id: id, texto: texto} ->
      texto_corto = if String.length(texto) > 60 do
        String.slice(texto, 0, 60) <> "..."
      else
        texto
      end
      IO.puts("#{id}: \"#{texto_corto}\"")
    end)

    # Medir secuencial
    tiempo_sec = BenchmarkUtils.determinar_tiempo_ejecucion({
      LimpiezaResenas,
      :limpiar_secuencial,
      [resenas]
    })

    # Medir concurrente
    tiempo_con = BenchmarkUtils.determinar_tiempo_ejecucion({
      LimpiezaResenas,
      :limpiar_concurrente,
      [resenas]
    })

    # Calcular speedup
    speedup = BenchmarkUtils.calcular_speedup(tiempo_con, tiempo_sec)

    # Mostrar resultados del procesamiento
    IO.puts("Proceso aplicado:")
    IO.puts("Convertir a minúsculas")
    IO.puts("Quitar tildes y caracteres especiales")
    IO.puts("Remover stopwords comunes")
    IO.puts("Crear resumen con 5 palabras clave")
    IO.puts("Sleep aleatorio: 5-15ms por reseña")

    # Mostrar algunos resultados limpios
    resultado_muestra = limpiar_secuencial(Enum.take(resenas, 3))
    IO.puts("Ejemplos de resultados:")
    Enum.each(resultado_muestra, fn {id, resumen} ->
      IO.puts("#{id}: \"#{resumen}\"")
    end)

    # Mostrar métricas de rendimiento
    IO.puts("Resultados de rendimiento:")
    IO.puts("Tiempo secuencial: #{tiempo_sec} microsegundos")
    IO.puts("Tiempo concurrente: #{tiempo_con} microsegundos")
    IO.puts("Speedup: #{Float.round(speedup, 2)}x")

    # Mensaje del benchmark
    mensaje = BenchmarkUtils.generar_mensaje(tiempo_con, tiempo_sec)
    IO.puts("\n#{mensaje}")

    {tiempo_sec, tiempo_con, speedup}
  end
end


LimpiezaResenas.ejecutar_comparacion()
