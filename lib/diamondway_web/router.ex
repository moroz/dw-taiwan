defmodule DiamondwayWeb.Router do
  use DiamondwayWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug DiamondwayWeb.Plugs.FetchUser
    plug DiamondwayWeb.Plugs.PublicIp
    plug DiamondwayWeb.Plugs.SetLocale
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug DiamondwayWeb.Plugs.FetchUser
    plug DiamondwayWeb.Plugs.RestrictAccess, :api
    plug DiamondwayWeb.Plugs.PublicIp
  end

  pipeline :public_api do
    plug DiamondwayWeb.Plugs.PublicIp
  end

  pipeline :admin do
    plug :browser
    plug DiamondwayWeb.Plugs.RestrictAccess
    plug DiamondwayWeb.Plugs.PublicIp
  end

  pages = [:venue, :faq]

  scope "/", DiamondwayWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/registration", RegistrationController, :new
    post "/registration", RegistrationController, :create
    get "/registration/success", RegistrationController, :success

    get "/check", RegistrationController, :check_status_form
    post "/check", RegistrationController, :check_status
    post "/resend_email", RegistrationController, :resend_email

    for page <- pages do
      get "/#{page}", PageController, page
    end

    get "/admin/login", SessionController, :new
    post "/admin/login", SessionController, :create
    get "/admin/logout", SessionController, :delete
  end

  if Mix.env() in [:dev, :staging] do
    scope "/dev" do
      pipe_through :browser

      get "/email/:type", DiamondwayWeb.EmailController, :preview

      forward("/graphiql", Absinthe.Plug.GraphiQL, schema: DiamondwayWeb.GraphQL.Schema)
      forward("/mailbox", Plug.Swoosh.MailboxPreview, base_path: "/dev/mailbox")
    end
  end

  scope "/api" do
    pipe_through :api

    forward "/", Absinthe.Plug, schema: DiamondwayWeb.GraphQL.Schema
  end

  scope "/admin", DiamondwayWeb do
    pipe_through :admin

    get "/*path", AdminController, :react, as: :admin_root
  end
end
