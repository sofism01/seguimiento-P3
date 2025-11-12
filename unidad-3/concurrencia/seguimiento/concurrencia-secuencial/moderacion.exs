defmodule Comentario do
  @moduledoc """
  Estructura para representar un comentario de usuario.
  """
  defstruct id: nil, texto: ""
end

defmodule Moderador do
  @moduledoc """
  Módulo para moderar comentarios de usuario de forma secuencial y concurrente.
  """
  @palabras_prohibidas ["violencia", "spam", "fraude", "prohibido"]

  @doc """
  Modera un comentario, devolviendo {id, estado} donde estado es :aprobado o :rechazado
  """
  def moderar(%Comentario{id: id, texto: texto}) do
    :timer.sleep(Enum.random(5..12))

    estado =
      if contiene_link?(texto) or texto_valoracion_length?(texto) == :rechazado or contiene_palabra_prohibida?(texto) do
        :rechazado
      else
        :aprobado
      end

    {id, estado}
  end

  @doc """
  Secuencial: un proceso por comentario, devuelve {ms, resultados}
  """
  def procesar_secuencial(lista_comentarios) when is_list(lista_comentarios) do
    {us, res} = :timer.tc(fn -> Enum.map(lista_comentarios, &moderar/1) end)
    {us_to_ms(us), res}
  end

  @doc """
  Concurrente: un proceso por comentario, devuelve {ms, resultados}
  """
  def procesar_concurrente(lista_comentarios) when is_list(lista_comentarios) do
    {us, res} =
      :timer.tc(fn ->
        lista_comentarios
        |> Task.async_stream(&moderar/1, max_concurrency: length(lista_comentarios), ordered: true, timeout: :infinity)
        |> Enum.map(fn {:ok, r} -> r end)
      end)

    {us_to_ms(us), res}
  end

  @doc """
  Mide y muestra speedup entre secuencial y concurrente
  """
  def speedup(lista_comentarios) do
    {t_seq, _} = procesar_secuencial(lista_comentarios)
    {t_conc, _} = procesar_concurrente(lista_comentarios)

    speedup =
      if t_conc == 0 do
        :infinity
      else
        Float.round(t_seq / t_conc, 2)
      end

    IO.puts("Secuencial: #{t_seq} ms, Concurrente: #{t_conc} ms, Speedup: #{inspect(speedup)}")
    {t_seq, t_conc, speedup}
  end

 # Funciones privadas

  defp contiene_link?(texto) do
    Regex.match?(~r/(https?:\/\/|www\.)/i, texto)
  end

  defp texto_valoracion_length?(texto) do
    len = String.trim(texto) |> String.length()

    cond do
      len < 5 -> :rechazado
      len > 300 -> :rechazado
      true -> :ok
    end
  end

  defp contiene_palabra_prohibida?(texto) do
    texto_down = String.downcase(texto)

    Enum.any?(@palabras_prohibidas, fn palabra ->
      Regex.match?(~r/\b#{Regex.escape(palabra)}\b/, texto_down)
    end)
  end

  defp us_to_ms(us), do: div(us, 1000)

  @doc """
  Función de inicio de ejemplo: crea comentarios de ejemplo, ejecuta moderación secuencial y concurrente,
  muestra resultados y el speedup.
  """
  def iniciar do
    comentarios = [
      %Comentario{id: 1, texto: "Hola, buen artículo."},
      %Comentario{id: 2, texto: "Visita http://spam.example.com para ofertas"},
      %Comentario{id: 3, texto: "Este comentario contiene violencia explícita"},
      %Comentario{id: 4, texto: "Comentario válido y claro."},
      %Comentario{id: 5, texto: String.duplicate("a", 350)}
    ]

    {t_seq, res_seq} = procesar_secuencial(comentarios)
    IO.puts("Secuencial (#{t_seq} ms):")
    IO.inspect(res_seq)

    {t_conc, res_conc} = procesar_concurrente(comentarios)
    IO.puts("Concurrente (#{t_conc} ms):")
    IO.inspect(res_conc)

    speedup(comentarios)
  end
end

Moderador.iniciar()
