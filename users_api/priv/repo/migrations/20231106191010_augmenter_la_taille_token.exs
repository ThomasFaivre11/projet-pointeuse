defmodule UsersApi.Repo.Migrations.ChangeTokenColumnType do
  use Ecto.Migration

  def change do
    alter table(:user_tokens) do
      modify :token, :text
    end
  end
end
