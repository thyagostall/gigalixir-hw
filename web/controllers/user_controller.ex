defmodule GigalixirHelloworld.UserController do
  use GigalixirHelloworld.Web, :controller

  plug :authenticate when action in [:index, :show]

  alias GigalixirHelloworld.User

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.html", users: users
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render_new_page conn, changeset
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render conn, "show.html", user: user
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> GigalixirHelloworld.Auth.login(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render_new_page conn, changeset
    end
  end

  defp render_new_page(conn, changeset) do
    render conn, "new.html", changeset: changeset
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page.")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end
end
