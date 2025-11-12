defmodule User do # elixir --sname validacion validacion_servidor.exs -> para ejecutar el servidor
  @moduledoc """
  Estructura para representar un usuario con datos básicos.
  """
  defstruct [:email, :edad, :nombre]
end

defmodule ValidacionServidor do
  @moduledoc """
  Módulo servidor que procesa la validación de usuarios.
  """
  @nombre_servicio_local :servicio_validacion

  @doc """
  Función principal que inicia el proceso servidor.
  """
  def main() do
    IO.puts("SERVIDOR DE VALIDACIÓN DE USUARIOS INICIADO")
    IO.puts("Nodo: #{Node.self()}")
    registrar_servicio(@nombre_servicio_local)
    procesar_validaciones()
  end

  # Funciones privadas

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp procesar_validaciones() do
    receive do
      {cliente, {:validar_usuario, usuario}} ->
        resultado = validar(usuario)
        send(cliente, resultado)
        procesar_validaciones()

      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor de validación terminando...")
    end
  end

  defp validar(%User{email: email, edad: edad, nombre: nombre}) do
    # Simular tiempo de procesamiento variable
    tiempo_sleep = Enum.random(3..10)
    :timer.sleep(tiempo_sleep)

    errores = []

    # Validar email (debe contener @)
    errores = if String.contains?(email || "", "@") do
      errores
    else
      ["email inválido (falta @)" | errores]
    end

    # Validar edad (>= 0)
    errores = if is_number(edad) and edad >= 0 do
      errores
    else
      ["edad inválida (debe ser >= 0)" | errores]
    end

    # Validar nombre (no vacío)
    errores = if is_binary(nombre) and String.trim(nombre) != "" do
      errores
    else
      ["nombre vacío" | errores]
    end

    # Retornar resultado
    resultado = if Enum.empty?(errores) do
      {email, :ok}
    else
      {email, {:error, Enum.reverse(errores)}}
    end

    # Mostrar resultado en servidor
    case resultado do
      {email, :ok} ->
        IO.puts("#{email}: OK")
      {email, {:error, errores}} ->
        errores_str = Enum.join(errores, ", ")
        IO.puts("#{email}: ERROR - #{errores_str}")
    end

    resultado
  end
end

ValidacionServidor.main()
