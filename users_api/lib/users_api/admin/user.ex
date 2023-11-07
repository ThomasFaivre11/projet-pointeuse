defmodule UsersApi.Admin.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, only: [:id, :username, :email, :inserted_at, :updated_at, :type]}
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
    |> put_password_hash();
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset

end
