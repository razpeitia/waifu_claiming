defmodule WaifuClaimingWeb.Router do
  use WaifuClaimingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug WaifuClaimingWeb.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WaifuClaimingWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/waifus", WaifuController
  end

  scope "/auth", WaifuClaimingWeb do
    pipe_through :browser

    get "/signout", AuthController, :signout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback

  end
end
