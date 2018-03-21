defmodule GigalixirHelloworld.Router do
  use GigalixirHelloworld.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GigalixirHelloworld do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hello-world/:name", HelloWorldController, :hello_world
    get "/users/", UserController, :index
    get "/users/:id", UserController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", GigalixirHelloworld do
  #   pipe_through :api
  # end
end
