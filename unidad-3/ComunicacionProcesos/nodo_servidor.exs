defmodule NodoServidor do
@moduledoc """
Módulo que actúa como un nodo secundario para procesar mensajes de cadenas.
"""
@nombre_servicio_local :servicio_cadenas

@doc """
Función principal que inicia el proceso secundario.
"""
def main() do
IO.puts("PROCESO SECUNDARIO")
registrar_servicio(@nombre_servicio_local)
procesar_mensajes()
end

# Funciones privadas

defp registrar_servicio(nombre_servicio_local),
do: Process.register(self(), nombre_servicio_local)

defp procesar_mensajes() do
receive do
{productor, mensaje} ->
respuesta = procesar_mensaje(mensaje)
send(productor, respuesta)
# Llama recursivamente para seguir recibiendo mensajes
if respuesta != :fin, do: procesar_mensajes()
end
end

defp procesar_mensaje(:fin), do: :fin

defp procesar_mensaje({:mayusculas, msg}), do: String.upcase(msg)

defp procesar_mensaje({:minusculas, msg}), do: String.downcase(msg)

defp procesar_mensaje({funcion, msg}) when is_function(funcion, 1), do: funcion.(msg)

defp procesar_mensaje(mensaje), do: "El mensaje \"#{mensaje}\" es desconocido."

end

NodoServidor.main()
