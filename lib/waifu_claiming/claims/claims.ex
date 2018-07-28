defmodule WaifuClaiming.Claims do
  @moduledoc """
  The Accounts context.
  """ 
  import Ecto.Query, warn: false
  import Ecto
  alias WaifuClaiming.Repo

  alias WaifuClaiming.Claims.Waifu

  def count_waifus() do
    Repo.aggregate(Waifu, :count, :id)
  end

  # todo: add params for max limit and page number
  def list_waifus(_params) do
    Repo.all(Waifu)
  end

  def new_waifu() do
  	Waifu.changeset(%Waifu{}, %{})
  end

  @doc """
  Creates a waifu.

  ## Examples

      iex> create_waifu(%{field: value})
      {:ok, %Waifu{}}

      iex> create_waifu(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """

  def status(%Waifu{status: 0}), do: "Waiting for approval"
  def status(%Waifu{status: 1}), do: "Approved"
  def status(%Waifu{status: 2}), do: "Rejected"

  def create_waifu(user, %{"waifu" => params}) do
    %{"avatar" => upload} = params
    uuid = Ecto.UUID.generate()
    extension = Path.extname(upload.filename)
    file_upload = "C:/Users/Ricardo/projects/waifu_claiming/assets/media/#{uuid}-waifu#{extension}"
    file_url = "/media/#{uuid}-waifu#{extension}"
    new_params = Map.merge(params, %{"avatar" => file_url, "status" => 0})
    
    result = user
    |> build_assoc(:waifus)
    |> Waifu.changeset(new_params)
    |> Repo.insert()
    
    case result do
      {:ok, _} ->
        File.cp(upload.path, file_upload)
      _        -> :ok
    end
    result
  end
end
