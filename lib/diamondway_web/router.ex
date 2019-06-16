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

  scope "/", DiamondwayWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/admin/", DiamondwayWeb do
    pipe_through :browser

    resources "/guests", GuestController
  end

  # Other scopes may use custom stacks.
  # scope "/api", DiamondwayWeb do
  #   pipe_through :api
  # end
end
