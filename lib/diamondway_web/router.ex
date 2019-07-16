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

  pipeline :admin do
    plug :browser
    plug DiamondwayWeb.Plugs.FetchUser
    plug DiamondwayWeb.Plugs.RestrictAccess
  end

  pages = [:venue, :faq, :contact]

  scope "/", DiamondwayWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create

    for page <- pages do
      get "/#{page}", PageController, page
    end

    get "/admin/login", SessionController, :new
    post "/admin/login", SessionController, :create
  end

  scope "/admin/", DiamondwayWeb do
    pipe_through :admin

    resources "/guests", GuestController
  end

  # Other scopes may use custom stacks.
  # scope "/api", DiamondwayWeb do
  #   pipe_through :api
  # end
end