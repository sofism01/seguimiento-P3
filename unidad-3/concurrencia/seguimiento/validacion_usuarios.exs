defmodule User do
  @moduledoc """
  Estructura para representar un usuario con datos básicos.
  """
  defstruct [:email, :edad, :nombre]
end

defmodule ValidacionUsuarios do
  @moduledoc """
  Módulo para validar registros de usuarios usando Benchmark.
  """

  # Cargar el módulo Benchmark
  Code.require_file("benchmark.ex", __DIR__)
  alias Benchmark, as: BenchmarkUtils

  @doc """
  Valida un usuario completamente.
  Verifica email con @, edad >= 0, nombre no vacío + sleep aleatorio.
  """
  def validar(%User{email: email, edad: edad, nombre: nombre}) do
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
    if Enum.empty?(errores) do
      {email, :ok}
    else
      {email, {:error, Enum.reverse(errores)}}
    end
  end

  @doc """
  Validación secuencial de usuarios.
  """
  def validar_secuencial(usuarios) do
    Enum.map(usuarios, &validar/1)
  end

  @doc """
  Validación concurrente de usuarios.
  """
  def validar_concurrente(usuarios) do
    usuarios
    |> Enum.map(fn usuario ->
      Task.async(fn -> validar(usuario) end)
    end)
    |> Task.await_many(15000)
  end

  @doc """
  Lista de usuarios de ejemplo (15 usuarios).
  """
  def lista_usuarios do
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

  @doc """
  Ejecuta la comparación usando Benchmark.
  """
  def ejecutar_comparacion do
    usuarios = lista_usuarios()

    IO.puts("VALIDACIÓN DE REGISTROS DE USUARIO")
    IO.puts("=" |> String.duplicate(55))

    IO.puts("Usuarios a validar: #{length(usuarios)}")
    IO.puts("Validaciones: email con @, edad >= 0, nombre no vacío")
    IO.puts("Sleep aleatorio: 3-10ms por usuario")

    # Medir secuencial
    tiempo_sec = BenchmarkUtils.determinar_tiempo_ejecucion({
      ValidacionUsuarios,
      :validar_secuencial,
      [usuarios]
    })

    # Medir concurrente
    tiempo_con = BenchmarkUtils.determinar_tiempo_ejecucion({
      ValidacionUsuarios,
      :validar_concurrente,
      [usuarios]
    })

    # Calcular speedup
    speedup = BenchmarkUtils.calcular_speedup(tiempo_con, tiempo_sec)

    # Mostrar algunos resultados de ejemplo
    IO.puts("Ejemplos de validación:")
    resultados_muestra = validar_secuencial(Enum.take(usuarios, 3))
    Enum.each(resultados_muestra, fn
      {email, :ok} ->
        IO.puts("#{email}: OK")
      {email, {:error, errores}} ->
        errores_str = Enum.join(errores, ", ")
        IO.puts("#{email}: ERROR - #{errores_str}")
    end)

    # Contar resultados
    todos_resultados = validar_secuencial(usuarios)
    validos = Enum.count(todos_resultados, fn {_, resultado} -> resultado == :ok end)
    invalidos = length(usuarios) - validos

    IO.puts("Resumen de validación:")
    IO.puts("Usuarios válidos: #{validos}")
    IO.puts("Usuarios inválidos: #{invalidos}")

    # Mostrar métricas de rendimiento
    IO.puts("Resultados de rendimiento:")
    IO.puts("Tiempo secuencial: #{tiempo_sec} microsegundos")
    IO.puts("Tiempo concurrente: #{tiempo_con} microsegundos")
    IO.puts("Speedup: #{Float.round(speedup, 2)}x")

    # Mensaje del benchmark
    mensaje = BenchmarkUtils.generar_mensaje(tiempo_con, tiempo_sec)
    IO.puts("\n#{mensaje}")

    {tiempo_sec, tiempo_con, speedup}
  end
end

ValidacionUsuarios.ejecutar_comparacion()
