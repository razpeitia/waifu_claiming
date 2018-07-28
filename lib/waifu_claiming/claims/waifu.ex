defmodule WaifuClaiming.Claims.Waifu do
  use Ecto.Schema
  import Ecto.Changeset
  alias WaifuClaiming.Claims.Waifu

  schema "waifus" do
    field :name, :string, null: false
    field :avatar, :string, null: false
    # 0 - Waiting for approval
    # 1 - Approved
    # 2 - Rejected
    field :status, :integer, null: false
    field :reason, :string

    belongs_to :user, WaifuClaiming.Accounts.User, foreign_key: :register
    
    timestamps()
  end
  
  def changeset(%Waifu{} = waifu, attrs) do
    waifu
    |> cast(attrs, [:name, :avatar, :status, :register, :reason])
    |> validate_required([:name, :avatar, :status, :register])
    |> unique_constraint(:name)
  end

end