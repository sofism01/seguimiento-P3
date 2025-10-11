defmodule Main do

  def main do

# Crear cursos
curso1 = Curso.crear("CS101", "Programación I", 5, "Dr. García")
curso2 = Curso.crear("MAT201", "Cálculo", 3, "Dra. López")

# Validar si es de alta carga
IO.puts("¿Es alta carga curso1? #{Curso.validar_curso(curso1)}")  # true
IO.puts("¿Es alta carga curso2? #{Curso.validar_curso(curso2)}")  # false

# Cambiar docente
curso1_nuevo = Curso.cambiar_docente(curso1, "Dr. Martínez")

# Mostrar información
IO.puts(Curso.mostrar_info(curso1))
IO.puts(Curso.mostrar_info(curso1_nuevo))

  end

end

Main.main()
