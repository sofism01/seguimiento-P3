defmodule Main do

  def main do

    estudiantes = registro_estudiantes()
    filtrar_por_nota(estudiantes)
    lista_mapas = convertir_tupla(estudiantes)
    agrupar_por_edad(lista_mapas)

  end

  def registro_estudiantes do
    estudiantes = [
      {"Sofia", 18, 4.8},
      {"Juan", 22, 3.2},
      {"Laura", 25, 4.0},
      {"Anna", 28, 2.2}
    ]
    Util.show_message("Estudiantes del curso: #{inspect(estudiantes)}")
    estudiantes
  end

  def filtrar_por_nota(estudiantes) do
    filtrados = Enum.filter(estudiantes, fn {_, _, nota} -> nota >= 3.0 end)
    Util.show_message("Estudiantes con nota mayor o igual a 3.0: #{inspect(filtrados)}")
  end

  def convertir_tupla(estudiantes) do
    lista_mapas = Enum.map(estudiantes, fn {v, k, w} -> %{nombre: v, edad: k, nota: w} end)
    Util.show_message("Lista de mapas: #{inspect(lista_mapas)}")
    lista_mapas
  end

  def agrupar_por_edad(lista_mapas) do
    filtrados = Enum.group_by(lista_mapas, fn estudiante ->
      cond do
        estudiante.edad < 20 -> "Menores de 20 años"
        estudiante.edad <= 25 and estudiante.edad > 20 -> "Entre 20 y 25 años"
        estudiante.edad >= 25 -> "Mayores de 25 años"
        true -> "Otro"
      end
    end)
    Util.show_message("Estudiantes agrupados por edad: #{inspect(filtrados)}")
  end

end

Main.main()
