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
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug DiamondwayWeb.Plugs.FetchUser
    plug DiamondwayWeb.Plugs.RestrictAccess, :api
    plug DiamondwayWeb.Plugs.PublicIp
  end

  pipeline :public_api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug :browser
    plug DiamondwayWeb.Plugs.RestrictAccess
    plug DiamondwayWeb.Plugs.PublicIp
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
    post "/resend_email", RegistrationController, :resend_email

    get "/payment/:token", PaymentController, :show

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

      for email <- ~w(registration confirmation backup payment)a do
        get "/email/#{email}", DiamondwayWeb.EmailController, email
      end

      forward("/mailbox", Plug.Swoosh.MailboxPreview, base_path: "/dev/mailbox")
    end
  end

  scope "/api" do
    pipe_through :public_api
    post "/payments", DiamondwayWeb.API.PaymentController, :confirm
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
