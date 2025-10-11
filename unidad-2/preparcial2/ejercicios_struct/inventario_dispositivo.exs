defmodule Main do

def main do

  # Crear dispositivos
dispositivo1 = Dispositivo.crear("D001", "Laptop", "Dell", :nuevo)
dispositivo2 = Dispositivo.crear("D002", "Tablet", "Apple", :usado)
dispositivo3 = Dispositivo.crear("D003", "Monitor", "Samsung", :dañado)

# Verificar si son aptos para préstamo
IO.puts("¿Dispositivo1 apto? #{Dispositivo.es_apto?(dispositivo1)}")  # true
IO.puts("¿Dispositivo2 apto? #{Dispositivo.es_apto?(dispositivo2)}")  # true
IO.puts("¿Dispositivo3 apto? #{Dispositivo.es_apto?(dispositivo3)}")  # false

# Actualizar estado
dispositivo1_usado = Dispositivo.actualizar_estado(dispositivo1, :usado)
dispositivo3_reparado = Dispositivo.actualizar_estado(dispositivo3, :usado)

# Mostrar información
IO.puts(Dispositivo.mostrar_info(dispositivo1))
IO.puts(Dispositivo.mostrar_info(dispositivo1_usado))
IO.puts(Dispositivo.mostrar_info(dispositivo3_reparado))

# Intentar estado inválido
IO.inspect(Dispositivo.actualizar_estado(dispositivo1, :roto))

end

end

Main.main()
