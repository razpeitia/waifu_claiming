defmodule WaifuClaimingWeb.Plugs.SetUser do
	import Plug.Conn
	import Phoenix.Controller

	alias WaifuClaiming.Accounts

	def init(_params) do
	end

	def call(conn, _params) do
		eid = get_session(conn, :user_eid)
		provider = get_session(conn, :user_provider)
		cond do
		   user = eid  && provider && Accounts.get_user_by(eid: eid, provider: provider) ->
		   	assign(conn, :user, user)
		   true ->
		   	assign(conn, :user, nil)
		end
	end
	
end