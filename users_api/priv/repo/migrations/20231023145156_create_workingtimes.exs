defmodule UsersApi.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :start, :naive_datetime
      add :end, :naive_datetime
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:workingtimes, [:user_id])
  end
end
