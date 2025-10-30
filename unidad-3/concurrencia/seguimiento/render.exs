defmodule Tpl do
  @moduledoc """
  Estructura para representar una mini-plantilla con variables.
  """
  defstruct id: nil, nombre: "", vars: %{}
end

defmodule Render do
  @doc """
  Renderiza una mini-plantilla reemplazando las variables en el template.
  Simula un costo de procesamiento basado en el tamaño del template y la cantidad de variables.
  """
  def render(%Tpl{id: id, nombre: template, vars: vars}) do
    html =
      Enum.reduce(vars, template, fn {k, v}, acc ->
        String.replace(acc, "{{#{k}}}", to_string(v))
      end)

    # costo aproximado (bytes + cantidad de variables) -> ms de espera para simular trabajo
    costo = byte_size(html) + map_size(vars) * 10
    :timer.sleep(costo_to_ms(costo))

    {id, html}
  end

  defp costo_to_ms(c), do: max(20, div(c, 10))

  @doc """
  Ejecuta secuencial (una por plantilla), devuelve {ms, resultados}
  """
  def render_all_sequential(tpls) when is_list(tpls) do
    {us, res} = :timer.tc(fn -> Enum.map(tpls, &render/1) end)
    {us_to_ms(us), res}
  end

  @doc """
  Ejecuta concurrente (un proceso por plantilla), devuelve {ms, resultados}
  """
  def render_all_concurrent(tpls) when is_list(tpls) do
    {us, res} =
      :timer.tc(fn ->
        tpls
        |> Task.async_stream(&render/1, max_concurrency: length(tpls), ordered: true, timeout: :infinity)
        |> Enum.map(fn {:ok, r} -> r end)
      end)

    {us_to_ms(us), res}
  end

  @doc """
  Mide y muestra speedup entre secuencial y concurrente
  """
  def speedup(tpls) when is_list(tpls) do
    {t_seq, _} = render_all_sequential(tpls)
    {t_conc, _} = render_all_concurrent(tpls)

    speedup =
      if t_conc == 0 do
        :infinity
      else
        Float.round(t_seq / t_conc, 2)
      end

    IO.puts("Secuencial: #{t_seq} ms, Concurrente: #{t_conc} ms, Speedup: #{inspect(speedup)}")
    {t_seq, t_conc, speedup}
  end

  defp us_to_ms(us), do: div(us, 1000)

  @doc """
  Función de inicio de ejemplo: crea plantillas de ejemplo, ejecuta render secuencial y concurrente,
  muestra resultados y el speedup.
  """
  def iniciar do
    tpls = [
      %Tpl{id: 1, nombre: "Hola {{nombre}}", vars: %{"nombre" => "Ana"}},
      %Tpl{id: 2, nombre: "<p>{{saludo}}, {{nombre}}</p>", vars: %{"saludo" => "Buen día", "nombre" => "Luis"}},
      %Tpl{id: 3, nombre: "Valor: {{v}}", vars: %{"v" => 12345}}
    ]

    {t_seq, res_seq} = render_all_sequential(tpls)
    IO.puts("Resultado secuencial (#{t_seq} ms):")
    IO.inspect(res_seq)

    {t_conc, res_conc} = render_all_concurrent(tpls)
    IO.puts("Resultado concurrente (#{t_conc} ms):")
    IO.inspect(res_conc)

    speedup(tpls)
  end
end


Render.iniciar()
