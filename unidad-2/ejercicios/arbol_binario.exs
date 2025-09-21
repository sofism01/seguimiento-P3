defmodule Main do
 @moduledoc """
  Módulo para encontrar todas las rutas desde la raíz hasta las hojas en un árbol binario
  donde la suma de los valores de los nodos en la ruta es igual a un valor objetivo.
  """
  defstruct valor: nil, izq: nil, der: nil  # Estructura para el nodo del árbol

  @doc """
  Función principal que ejecuta el ejemplo de búsqueda de rutas en un árbol binario.
  """
  def main do
    # Ejemplo de árbol:
    #       5
    #      / \
    #     4   8
    #    /   / \
    #   11  13  4
    #  /  \\     \
    # 7    2     1
    arbol = %Main{
      valor: 5,
      izq: %Main{
        valor: 4,
        izq: %Main{
          valor: 11,
          izq: %Main{valor: 7},
          der: %Main{valor: 2}
        }
      },
      der: %Main{
        valor: 8,
        izq: %Main{valor: 13},
        der: %Main{
          valor: 4,
          der: %Main{valor: 1}
        }
      }
    }

    objetivo = 22
    IO.inspect(rutas_objetivo(arbol, objetivo))
  end

  @doc """
  Encuentra todas las rutas desde la raíz hasta las hojas en un árbol binario
  donde la suma de los valores de los nodos en la ruta es igual a un valor objetivo.
  """
  def rutas_objetivo(nil, _objetivo), do: [] # Caso base: árbol vacío

  def rutas_objetivo(%Main{valor: valor, izq: nil, der: nil}, objetivo) when valor == objetivo do
    [[valor]] # Caso base: si el nodo es hoja y cumple el objetivo, retorna la ruta
  end

  def rutas_objetivo(%Main{valor: _valor, izq: nil, der: nil}, _objetivo), do: [] # Caso base: si el nodo es hoja y no cumple el objetivo, retorna vacío

  def rutas_objetivo(%Main{valor: valor, izq: izq, der: der}, objetivo) do # Caso recursivo: busca rutas en subárbol izquierdo y derecho
    rutas_izq = for ruta <- rutas_objetivo(izq, objetivo - valor), do: [valor | ruta]
    rutas_der = for ruta <- rutas_objetivo(der, objetivo - valor), do: [valor | ruta]
    rutas_izq ++ rutas_der
  end

end

Main.main()
