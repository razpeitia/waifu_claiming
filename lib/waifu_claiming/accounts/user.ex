defmodule WaifuClaiming.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias WaifuClaiming.Accounts.User


  schema "users" do
    field :eid, :string, null: false
    field :email, :string
    field :provider, :string, null: false
    field :token, :string
    field :username, :string

    has_many(:waifus, WaifuClaiming.Claims.Waifu, foreign_key: :register)

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:eid, :username, :email, :token, :provider])
    |> validate_required([:eid, :username, :email, :provider])
    |> unique_constraint(:eid, name: :users_eid_provider_index)
  end
end
