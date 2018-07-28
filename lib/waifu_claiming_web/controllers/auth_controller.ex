defmodule WaifuClaimingWeb.AuthController do
	use WaifuClaimingWeb, :controller
	plug Ueberauth

	alias WaifuClaiming.Accounts

	def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
		attrs = %{
			provider: to_string(auth.provider),
			eid: auth.uid,
			email: auth.info.email,
			username: auth.info.name
		}
		case Accounts.create_or_update(attrs) do
			{:ok, user} ->
				conn
				|> put_flash(:info, generate_greeting())
				|> put_session(:user_eid, user.eid)
				|> put_session(:user_provider, user.provider)
				|> redirect(to: page_path(conn, :index))
			{:error, _reason} ->
				conn
				|> put_flash(:error, "Error in signin")
				|> redirect(to: page_path(conn, :index))
		end
	end

	defp generate_greeting() do
		["Okaerinasai", "Ohayoi", "Konbanwa", "Konnichiwa"]
		|> Enum.random()
	end

	def signout(conn, _params) do
		conn
		|> configure_session(drop: true)
		|> redirect(to: page_path(conn, :index))
	end
end