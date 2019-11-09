defmodule DiamondwayWeb.Router do
  use DiamondwayWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug DiamondwayWeb.Plugs.FetchUser
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug DiamondwayWeb.Plugs.FetchUser
    plug DiamondwayWeb.Plugs.RestrictAccess, :api
  end

  pipeline :admin do
    plug :browser
    plug DiamondwayWeb.Plugs.RestrictAccess
  end

  pages = [:venue, :faq, :ticketing]

  scope "/", DiamondwayWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/registration", RegistrationController, :new
    post "/registration", RegistrationController, :create
    get "/registration/success", RegistrationController, :success

    get "/check", RegistrationController, :check_status_form
    post "/check", RegistrationController, :check_status

    for page <- pages do
      get "/#{page}", PageController, page
    end

    get "/admin/login", SessionController, :new
    post "/admin/login", SessionController, :create
    get "/admin/logout", SessionController, :delete
  end

  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      for email <- ~w(registration confirmation backup)a do
        get "/email/#{email}", DiamondwayWeb.EmailController, email
      end

      forward("/mailbox", Plug.Swoosh.MailboxPreview, base_path: "/dev/mailbox")
    end
  end

  scope "/api" do
    pipe_through :api

    forward "/", Absinthe.Plug, schema: DiamondwayWeb.GraphQL.Schema
  end

  scope "/admin", DiamondwayWeb do
    pipe_through :admin

    get "/csv_export", AdminController, :csv_export
    get "/*path", AdminController, :react, as: :admin_root
  end
end
