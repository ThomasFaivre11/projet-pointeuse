defmodule UsersApi.Admin.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :type, :string
    field :username, :string
    field :password, :string
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :type, :password])
    |> validate_required([:username, :email, :type, :password])
    |> unique_constraint(:email)
  end

end
