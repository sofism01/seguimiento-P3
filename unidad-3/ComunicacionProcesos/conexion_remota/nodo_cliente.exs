defmodule NodoCliente do
@moduledoc """
Módulo que actúa como un nodo principal para enviar mensajes a un nodo secundario y recibir respuestas.
"""

# Para ejecutar como modo remoto: elixir --name nodocliente@ 192.168.137.87 --cookie mi_cookie nodo_cliente.exs

@nombre_servicio_local :servicio_respuesta
@servicio_local {@nombre_servicio_local, :"nodocliente@ 192.168.137.87"}
@nodo_remoto :"nodoservidor@ 192.168.137.87"
@servicio_remoto {:servicio_cadenas, @nodo_remoto}
# Lista de mensajes a procesar
@mensajes [
{:mayusculas, "Juan"}, {:mayusculas, "Ana"},
{:minusculas, "Diana"}, {&String.reverse/1, "Julián"},
"Uniquindio", :fin
]

@doc """
Función principal que inicia el proceso principal.
"""
def main() do
IO.puts("PROCESO PRINCIPAL")
@nombre_servicio_local
|> registrar_servicio()
establecer_conexion(@nodo_remoto)
|> iniciar_produccion()
end

# Funciones privadas

defp registrar_servicio(nombre_servicio_local),
do: Process.register(self(), nombre_servicio_local)

defp establecer_conexion(nodo_remoto) do
Node.connect(nodo_remoto)
end

defp iniciar_produccion(false),
do: IO.puts("No se pudo conectar con el nodo servidor")

defp iniciar_produccion(true) do
enviar_mensajes()
recibir_respuestas()
end

defp enviar_mensajes() do
Enum.each(@mensajes, &enviar_mensaje/1)
end

defp enviar_mensaje(mensaje) do
send(@servicio_remoto, {@servicio_local, mensaje})
end

defp recibir_respuestas() do
receive do
:fin ->
:ok

respuesta ->
IO.puts("\t -> \"#{respuesta}\"")
recibir_respuestas()
end
end

end

NodoCliente.main()
