defmodule Main do

def main do

# Crear estudiantes
estudiante1 = Estudiante.crear("2021001", "Juan Pérez", "juan.perez@uq.edu.co", 5)
estudiante2 = Estudiante.crear("2021002", "María López", "maria.lopez@gmail.com", 7)

# Validar email institucional
IO.puts("¿Email válido estudiante1? #{Estudiante.validar_email_institucional(estudiante1)}")  # true
IO.puts("¿Email válido estudiante2? #{Estudiante.validar_email_institucional(estudiante2)}")  # false

# Promover semestre
estudiante1_promovido = Estudiante.promover_semestre(estudiante1)
estudiante2_promovido = Estudiante.promover_semestre(estudiante2)

# Mostrar información
IO.puts("Antes de promover:")
IO.puts(Estudiante.mostrar_info(estudiante1))

IO.puts("Después de promover:")
IO.puts(Estudiante.mostrar_info(estudiante1_promovido))

IO.puts("Estudiante 2 promovido:")
IO.puts(Estudiante.mostrar_info(estudiante2_promovido))

end

end

Main.main()
