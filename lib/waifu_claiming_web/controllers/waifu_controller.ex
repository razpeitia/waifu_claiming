defmodule WaifuClaimingWeb.WaifuController do
  use WaifuClaimingWeb, :controller
  
  plug WaifuClaimingWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]

  alias WaifuClaiming.Claims

  def index(conn, params) do
    waifus = Claims.list_waifus(params)
    waifu_count = Claims.count_waifus()
    render conn, "index.html", waifus: waifus, waifu_count: waifu_count
  end

  def show(_conn, _params) do
    
  end

  def new(conn, _params) do
    changeset = Claims.new_waifu()
    render conn, "new.html", changeset: changeset
  end

  def create(conn, params) do
    case Claims.create_waifu(conn.assigns.user, params) do
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
      {:ok, waifu} ->
        conn
        |> put_flash(:success, "#{waifu.name} created")
        |> redirect(to: page_path(conn, :index))
    end
  end

  def update(_conn, _params) do
    
  end

  def edit(_conn, _params) do
    
  end

  def delete(_conn, _params) do
    
  end
end