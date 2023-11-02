defmodule UsersApi.Repo.Migrations.CreateWorkteams do
  use Ecto.Migration

  def change do
    create table(:workteams, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :team_name, :string
      add :worker_id, references(:users, on_delete: :delete_all, type: :binary_id)
      add :manager_id, references(:users, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:workteams, [:worker_id])
    create index(:workteams, [:manager_id])
  end
end
