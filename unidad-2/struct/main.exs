defmodule Main do

  def main do

  #creacion de un struct
  u1 = %User{name: "Sofi", password: "1234"}
  IO.inspect(u1)

  #acceso a los campos del struct
  IO.puts(u1.name)

  #actualizacion de un struct
  u2 = %User{u1 | password: "5678"}
  IO.inspect(u2)

  end

end

Main.main()
