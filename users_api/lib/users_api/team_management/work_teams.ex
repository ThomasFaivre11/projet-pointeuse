defmodule UsersApi.TeamManagement.WorkTeams do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "workteams" do
    field :team_name, :string
    field :worker_id, :binary_id
    field :manager_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(work_teams, attrs) do
    work_teams
    |> cast(attrs, [:team_name, :manager_id, :worker_id])
    |> validate_required([:team_name, :manager_id, :worker_id])
  end
end
