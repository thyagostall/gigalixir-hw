defmodule GigalixirHelloworld.UserView do
  use GigalixirHelloworld.Web, :view

  alias GigalixirHelloworld.User

  def first_name(%User{name: name}) do
    name
    |> String.trim
    |> String.split(~r/ +/)
    |> Enum.at(0)
  end
end
