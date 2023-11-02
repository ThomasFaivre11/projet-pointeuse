defmodule UsersApi.State.Clock do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset
  alias UsersApi.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "clocks" do
    field :status, :boolean, default: false
    field :time, :naive_datetime
    field :user_id, :binary_id
    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user_id])
    |> validate_required([:time, :status, :user_id])
  end

  def get_clocks_by_user_id(id) do
    query = from c in UsersApi.State.Clock, where: c.user_id == ^id
    Repo.all(query)
  end

end
