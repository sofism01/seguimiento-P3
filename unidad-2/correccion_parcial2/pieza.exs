defmodule Pieza do
  defstruct [:codigo, :nombre, :valor, :unidad, :stock]
end

defmodule Parcial do
  # Punto 1A: Definir struct Pieza y función que lea archivo y retorne {:ok, Pieza.contenido}
  def leer_piezas(ruta) do
    case File.read(ruta) do
      {:ok, contenido} ->
        lineas = String.split(contenido, "\n", trim: true)
        piezas = parsear_piezas(lineas, [])
        {:ok, piezas}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp parsear_piezas([], acc), do: Enum.reverse(acc)

  defp parsear_piezas([linea | resto], acc) do
    case String.split(linea, ",") do
      [codigo, nombre, valor, unidad, stock] ->
        pieza = %Pieza{
          codigo: codigo,
          nombre: nombre,
          valor: String.to_float(String.trim(valor)),
          unidad: unidad,
          stock: String.to_integer(String.trim(stock))
        }
        parsear_piezas(resto, [pieza | acc])
      _ ->
        parsear_piezas(resto, acc)
    end
  end

  # Punto 1B: Recursivo - contar cuántas piezas tienen stock < umbral
  def contar_stock_bajo([], _umbral, cont), do: cont
  def contar_stock_bajo([%Pieza{stock: s} | resto], umbral, cont) when s < umbral do
    contar_stock_bajo(resto, umbral, cont + 1)
  end
  def contar_stock_bajo([_ | resto], umbral, cont), do: contar_stock_bajo(resto, umbral, cont)

  # Punto 2: Estructura Movimiento y procesamiento de movimientos
  defmodule Movimiento do
    defstruct [:codigo, :tipo, :cantidad, :fecha]
  end

  def leer_movimientos(ruta) do
    case File.read(ruta) do
      {:ok, contenido} ->
        lineas = String.split(contenido, "\n", trim: true)
        movs = parsear_movimientos(lineas, [])
        {:ok, movs}

      {:error, razon} ->
        {:error, razon}
    end
  end

  defp parsear_movimientos([], acc), do: Enum.reverse(acc)
  defp parsear_movimientos([linea | resto], acc) do
    case String.split(linea, ",") do
      [codigo, tipo, cantidad, fecha] ->
        mov = %Movimiento{
          codigo: codigo,
          tipo: String.to_atom(tipo),
          cantidad: String.to_integer(cantidad),
          fecha: fecha
        }
        parsear_movimientos(resto, [mov | acc])

      _ ->
        parsear_movimientos(resto, acc)
    end
  end

  def aplicar_movimientos(piezas, movimientos) do
    actualizado =
      for pieza <- piezas do
        movs = Enum.filter(movimientos, fn m -> m.codigo == pieza.codigo end)
        nuevo_stock = actualizar_stock(pieza.stock, movs)
        %{pieza | stock: nuevo_stock}
      end

    datos =
      Enum.map(actualizado, fn p ->
        "#{p.codigo},#{p.nombre},#{p.valor},#{p.unidad},#{p.stock}"
      end)
      |> Enum.join("\n")

    File.write("inventario_actual.csv", datos)
    actualizado
  end

  defp actualizar_stock(stock, []), do: stock
  defp actualizar_stock(stock, [m | resto]) do
    nuevo_stock =
      case m.tipo do
        :ENTRADA -> stock + m.cantidad
        :SALIDA -> stock - m.cantidad
      end

    actualizar_stock(nuevo_stock, resto)
  end

  # Punto 3: Función recursiva para contar unidades movidas en un rango de fechas
  def contar_unidades_movidas_rango([], _fini, _ffin), do: 0

  def contar_unidades_movidas_rango([movimiento | resto], fini, ffin) do
    if fecha_en_rango?(movimiento.fecha, fini, ffin) do
      movimiento.cantidad + contar_unidades_movidas_rango(resto, fini, ffin)
    else
      contar_unidades_movidas_rango(resto, fini, ffin)
    end
  end

  defp fecha_en_rango?(fecha, fini, ffin) do
    fecha >= fini && fecha <= ffin
  end

  # Punto 4: Función recursiva para eliminar duplicados por código, preservando primer orden
  def eliminar_duplicados_recursivo(piezas) do
    eliminar_duplicados_aux(piezas, [])
  end

  defp eliminar_duplicados_aux([], acc) do
    reversar_lista(acc, [])
  end

  defp eliminar_duplicados_aux([pieza | resto], acc) do
    if codigo_existe_recursivo?(pieza.codigo, acc) do
      eliminar_duplicados_aux(resto, acc)
    else
      eliminar_duplicados_aux(resto, [pieza | acc])
    end
  end

  defp codigo_existe_recursivo?(_codigo, []), do: false

  defp codigo_existe_recursivo?(codigo, [pieza | resto]) do
    if pieza.codigo == codigo do
      true
    else
      codigo_existe_recursivo?(codigo, resto)
    end
  end

  defp reversar_lista([], acc), do: acc
  defp reversar_lista([head | tail], acc) do
    reversar_lista(tail, [head | acc])
  end

end
