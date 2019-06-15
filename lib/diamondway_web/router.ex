defmodule DiamondwayWeb.Router do
  use DiamondwayWeb, :router

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

  scope "/.well-known/", DiamondwayWeb do
    get "/acme-challenge/WHO13ceSmFjzo3Aq9Ez5pVUsWT5KNjEk2tq2kAw2GGQ", AcmeController, :challenge
  end

  scope "/", DiamondwayWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", DiamondwayWeb do
  #   pipe_through :api
  # end
end
