defmodule GigalixirHelloworld.Repo do
  alias GigalixirHelloworld.User

  def all(User) do
    [
      %User{id: "1", name: "Thyago", username: "thyagostall", password: "123456"},
      %User{id: "2", name: "José", username: "josevalim", password: "123456"},
      %User{id: "3", name: "Chris", username: "chrismccord", password: "123456"},
    ]
  end
  def all(_module), do: []

  def get(module, id) do
    Enum.find all(module), fn item -> item.id == to_string(id) end
  end

  def get_by(module, params) do
    Enum.find all(module), fn item ->
      Enum.all? params, fn {param, value} -> Map.get(item, param) == value end
    end
  end
end
