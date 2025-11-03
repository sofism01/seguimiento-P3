defmodule Cookie do
@moduledoc """
Genera y muestra una cookie segura codificada en Base64.
"""
@longitud_llave 128

@doc """
Función principal para generar y mostrar la cookie.
"""
def main() do
:crypto.strong_rand_bytes(@longitud_llave)
|> Base.encode64()
|> IO.puts()
end
end

Cookie.main()
