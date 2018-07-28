defmodule WaifuClaiming.Repo.Migrations.CreateSchema do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :eid, :string, null: false
      add :username, :string
      add :email, :string
      add :token, :string
      add :provider, :string, null: false
      
      timestamps()
    end
    create index(:users, [:eid, :provider], unique: true)

    create table(:waifus) do
      add :name, :string, null: false
      add :avatar, :string, null: false
      
      # 0 - Waiting for approval
      # 1 - Approved
      # 2 - Rejected
      add :status, :integer, null: false
      add :register, references(:users)
      add :reason, :string
      timestamps()
    end
    create index(:waifus, [:name], unique: true)

    create table(:claims) do
      add :waifu_id, references(:waifus)
      add :user_id, references(:users)

      timestamps()
    end
    create index(:claims, [:waifu_id], unique: true)
    create index(:claims, [:user_id], unique: true)

  end
end
