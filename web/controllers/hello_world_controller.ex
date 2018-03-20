defmodule GigalixirHelloworld.HelloWorldController do
  use GigalixirHelloworld.Web, :controller

  def hello_world(conn, %{"name" => name}) do
    render conn, "hello_world.html", name: name
  end
end
