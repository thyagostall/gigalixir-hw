defmodule GigalixirHelloworld.PageController do
  use GigalixirHelloworld.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
