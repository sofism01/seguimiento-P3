defmodule User do # elixir --sname cliente_validacion validacion_cliente.exs -> para ejecutar el cliente
  @moduledoc """
  Estructura para representar un usuario con datos básicos.
  """
  defstruct [:email, :edad, :nombre]
end

defmodule ValidacionCliente do
  @moduledoc """
  Módulo cliente que coordina la validación de usuarios usando nodos distribuidos.
  """
  @nombre_servicio_local :servicio_coordinador_validacion

  @doc """
  Función principal que inicia el proceso cliente.
  """
  def main() do
    IO.puts("COORDINADOR DE VALIDACIÓN DE USUARIOS INICIADO")
    IO.puts("Nodo: #{Node.self()}")

    @nombre_servicio_local
    |> registrar_servicio()

    # Intentar conectar usando el nombre real del nodo servidor
    nodo_servidor = obtener_nodo_servidor()
    IO.puts("Intentando conectar a: #{nodo_servidor}")

    establecer_conexion(nodo_servidor)
    |> iniciar_validacion(nodo_servidor)
  end

  # Funciones privadas

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp obtener_nodo_servidor() do
    # Buscar nodos disponibles que contengan "validacion"
    nodos_disponibles = Node.list()
    IO.puts("Nodos disponibles: #{inspect(nodos_disponibles)}")

    case Enum.find(nodos_disponibles, fn nodo ->
      nodo |> Atom.to_string() |> String.contains?("validacion")
    end) do
      nil ->
        # Construir nombre del servidor usando el mismo hostname
        hostname = Node.self() |> Atom.to_string() |> String.split("@") |> Enum.at(1)
        String.to_atom("validacion@#{hostname}")
      nodo -> nodo
    end
  end

  defp establecer_conexion(nodo_remoto) do
    case Node.connect(nodo_remoto) do
      true ->
        IO.puts("Conectado exitosamente a #{nodo_remoto}")
        true
      false ->
        IO.puts("No se pudo conectar a #{nodo_remoto}")
        false
      :ignored ->
        IO.puts("Conexión ignorada (ya existe)")
        true
    end
  end

  defp iniciar_validacion(false, _nodo_servidor),
    do: IO.puts("No se pudo conectar con el servidor de validación")

  defp iniciar_validacion(true, nodo_servidor) do
    servicio_remoto = {:servicio_validacion, nodo_servidor}
    servicio_local = {@nombre_servicio_local, Node.self()}

    usuarios = lista_usuarios()

    IO.puts("\nINICIANDO VALIDACIÓN DE USUARIOS DISTRIBUIDA")
    IO.puts("Usuarios a validar: #{length(usuarios)}")

    IO.puts("\nValidaciones aplicadas:")
    IO.puts("Email con @ obligatorio")
    IO.puts("Edad >= 0")
    IO.puts("Nombre no vacío")
    IO.puts("Sleep aleatorio: 3-10ms por usuario")

    # Validación secuencial distribuida
    IO.puts("\n--- VALIDACIÓN SECUENCIAL ---")
    {resultados_sec, tiempo_sec} = validar_secuencial_distribuida(usuarios, servicio_remoto, servicio_local)

    mostrar_validacion("SECUENCIAL", resultados_sec, tiempo_sec)

    # Validación concurrente distribuida
    IO.puts("\n--- VALIDACIÓN CONCURRENTE ---")
    {resultados_con, tiempo_con} = validar_concurrente_distribuida(usuarios, servicio_remoto, servicio_local)

    mostrar_validacion("CONCURRENTE", resultados_con, tiempo_con)

    # Calcular speedup
    speedup = if tiempo_con > 0, do: tiempo_sec / tiempo_con, else: 1.0
    IO.puts("\nRESUMEN DE RENDIMIENTO:")
    IO.puts("Tiempo secuencial: #{tiempo_sec} ms")
    IO.puts("Tiempo concurrente: #{tiempo_con} ms")
    IO.puts("Speedup: #{Float.round(speedup, 2)}x")

    if speedup > 1.0 do
      mejora = (speedup - 1.0) * 100
      IO.puts("Mejora de rendimiento: #{Float.round(mejora, 1)}%")
    end

    # Estadísticas de validación
    validos = Enum.count(resultados_sec, fn {_, resultado} -> resultado == :ok end)
    invalidos = length(usuarios) - validos

    IO.puts("\nResumen de validación:")
    IO.puts("Usuarios válidos: #{validos}")
    IO.puts("Usuarios inválidos: #{invalidos}")
    IO.puts("Tasa de éxito: #{Float.round(validos / length(usuarios) * 100, 1)}%")

    # Finalizar servidor
    send(servicio_remoto, {servicio_local, :fin})
    receive do
      :fin -> IO.puts("Validación de usuarios completada exitosamente!")
    after
      2000 -> IO.puts("Timeout esperando confirmación del servidor")
    end
  end

  defp validar_secuencial_distribuida(usuarios, servicio_remoto, servicio_local) do
    inicio = :os.system_time(:millisecond)

    IO.puts("Validando #{length(usuarios)} usuarios secuencialmente...")

    resultados = Enum.map(usuarios, fn usuario ->
      enviar_usuario(usuario, servicio_remoto, servicio_local)
      recibir_validacion()
    end)

    fin = :os.system_time(:millisecond)
    tiempo_ms = fin - inicio

    {resultados, tiempo_ms}
  end

  defp validar_concurrente_distribuida(usuarios, servicio_remoto, servicio_local) do
    inicio = :os.system_time(:millisecond)

    IO.puts("Validando #{length(usuarios)} usuarios concurrentemente...")

    # Enviar todos los usuarios
    Enum.each(usuarios, fn usuario ->
      enviar_usuario(usuario, servicio_remoto, servicio_local)
    end)

    # Recibir todas las validaciones
    resultados = Enum.map(usuarios, fn _ -> recibir_validacion() end)

    fin = :os.system_time(:millisecond)
    tiempo_ms = fin - inicio

    {resultados, tiempo_ms}
  end

  defp enviar_usuario(usuario, servicio_remoto, servicio_local) do
    send(servicio_remoto, {servicio_local, {:validar_usuario, usuario}})
  end

  defp recibir_validacion() do
    receive do
      resultado -> resultado
    after
      5000 -> {"timeout", {:error, ["timeout de validación"]}}
    end
  end

  defp lista_usuarios do
    [
      # Usuarios válidos
      %User{email: "ana@correo.com", edad: 25, nombre: "Ana García"},
      %User{email: "carlos@email.com", edad: 30, nombre: "Carlos López"},
      %User{email: "maria@test.com", edad: 28, nombre: "María Rodríguez"},
      %User{email: "pedro@valid.com", edad: 35, nombre: "Pedro Martínez"},
      %User{email: "lucia@ejemplo.com", edad: 22, nombre: "Lucía Fernández"},
      %User{email: "diego@correo.com", edad: 40, nombre: "Diego Sánchez"},
      %User{email: "sofia@email.com", edad: 26, nombre: "Sofía Torres"},
      %User{email: "javier@test.com", edad: 32, nombre: "Javier Ruiz"},

      # Usuarios con errores
      %User{email: "sin_arroba.com", edad: 25, nombre: "Sin Arroba"},
      %User{email: "valido@correo.com", edad: -5, nombre: "Edad Negativa"},
      %User{email: "otro@email.com", edad: 30, nombre: ""},
      %User{email: "", edad: 22, nombre: "Email Vacío"},
      %User{email: "multiple_errores.com", edad: -10, nombre: ""},
      %User{email: nil, edad: nil, nombre: nil},
      %User{email: "ultimo@test.com", edad: 29, nombre: "Usuario Final"}
    ]
  end

  defp mostrar_validacion(tipo, resultados, tiempo_ms) do
    IO.puts("\nValidación #{tipo}:")
    IO.puts("Tiempo total: #{tiempo_ms} ms")

    # Mostrar algunos ejemplos de validación
    IO.puts("\nEjemplos de validación:")
    resultados
    |> Enum.take(5)
    |> Enum.each(fn
      {email, :ok} ->
        IO.puts("#{email}: OK")
      {email, {:error, errores}} ->
        errores_str = Enum.join(errores, ", ")
        IO.puts("#{email}: ERROR - #{errores_str}")
    end)

    if length(resultados) > 5 do
      IO.puts("  ... y #{length(resultados) - 5} usuarios más")
    end
  end
end

ValidacionCliente.main()
