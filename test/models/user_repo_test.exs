defmodule GigalixirHelloworld.UserRepoTest do
  use GigalixirHelloworld.ModelCase
  alias GigalixirHelloworld.User

  @valid_attrs %{name: "A User", username: "auser"}

  test "converts unique_constraint on username to error" do
    insert_user(username: "unique_user")
    attrs = Map.put(@valid_attrs, :username, "unique_user")
    changeset = User.changeset(%User{}, attrs)

    assert {:error, changeset} = Repo.insert(changeset)
    assert [username: {"has already been taken", []}] == changeset.errors
  end
end
