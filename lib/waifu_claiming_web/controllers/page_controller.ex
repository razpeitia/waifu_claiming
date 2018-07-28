defmodule WaifuClaimingWeb.PageController do
  use WaifuClaimingWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", next_sunday: next_sunday()
  end

  defp next_sunday() do
  	today = Timex.to_date(Timex.now("America/Monterrey"))
  	shift_days = Enum.at([6, 5, 4, 3, 2, 1, 7], Timex.weekday(today) - 1)
  	next_sunday = Timex.shift(today, days: shift_days)
  	Timex.format!(next_sunday, "{YYYY}-{0M}-{D}")
  end
end
