defmodule Todo.Router do
  use Todo.Web, :router

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

  scope "/", Todo do
    pipe_through :browser # Use the default browser stack

    post "/users", Authentication.Controller, :register
    post "/sessions", Authentication.Controller, :authenticate
    get "/login", Authentication.Controller, :login
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Todo do
  #   pipe_through :api
  # end
end
