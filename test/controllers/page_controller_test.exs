defmodule GigalixirHelloworld.PageControllerTest do
  use GigalixirHelloworld.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Gigalixir Hello World!"
  end
end
