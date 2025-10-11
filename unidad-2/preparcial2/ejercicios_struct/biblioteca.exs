defmodule Main do

  def main do

# Crear un libro
libro = Libro.crear("978-0134685991", "Effective Java", "Joshua Bloch", 2017)

IO.puts("Estado inicial:")
IO.puts(Libro.mostrar_info(libro))
IO.puts("¿Disponible? #{Libro.disponible?(libro)}")

# Prestar el libro (retorna nueva instancia)
libro_prestado = Libro.prestar(libro)

IO.puts("\nDespués de prestar:")
IO.puts(Libro.mostrar_info(libro_prestado))
IO.puts("¿Disponible? #{Libro.disponible?(libro_prestado)}")

# Devolver el libro (retorna nueva instancia)
libro_devuelto = Libro.devolver(libro_prestado)

IO.puts("\nDespués de devolver:")
IO.puts(Libro.mostrar_info(libro_devuelto))
IO.puts("¿Disponible? #{Libro.disponible?(libro_devuelto)}")

# El libro original no cambió (inmutabilidad)
IO.puts("\nLibro original (sin cambios):")
IO.puts(Libro.mostrar_info(libro))

  end

end

Main.main()
