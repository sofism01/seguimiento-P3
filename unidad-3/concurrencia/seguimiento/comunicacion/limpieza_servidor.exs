defmodule Review do # elixir --sname limpieza limpieza_servidor.exs -> para ejecutar el servidor
  @moduledoc """
  Estructura para representar una reseña de cliente.
  """
  defstruct [:id, :texto]
end

defmodule LimpiezaServidor do
  @moduledoc """
  Módulo servidor que procesa la limpieza de reseñas de clientes.
  """
  @nombre_servicio_local :servicio_limpieza

  # Lista de stopwords en español
  @stopwords ["el", "la", "de", "que", "y", "a", "en", "un", "es", "se", "no",
              "te", "lo", "le", "da", "su", "por", "son", "con", "para", "al",
              "del", "los", "las", "una", "muy", "mi", "me", "más", "pero", "ya"]

  @doc """
  Función principal que inicia el proceso servidor.
  """
  def main() do
    IO.puts("SERVIDOR DE LIMPIEZA DE RESEÑAS INICIADO")
    IO.puts("Nodo: #{Node.self()}")
    registrar_servicio(@nombre_servicio_local)
    procesar_resenas()
  end

  # Funciones privadas

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp procesar_resenas() do
    receive do
      {cliente, {:limpiar_resena, resena}} ->
        resultado = limpiar(resena)
        send(cliente, resultado)
        procesar_resenas()

      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor de limpieza terminando...")
    end
  end

  defp limpiar(%Review{id: id, texto: texto}) do
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

    IO.puts("#{id} limpiado: \"#{resumen}\"")
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
end

LimpiezaServidor.main()
