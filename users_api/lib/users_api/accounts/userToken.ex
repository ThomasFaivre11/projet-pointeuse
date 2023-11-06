defmodule UsersApi.Accounts.UserToken do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_tokens" do
    field :token, :string
    belongs_to :user, UsersApi.Accounts.User, type: :binary_id

    timestamps()
  end

  def changeset(user_token, attrs) do
    user_token
    |> cast(attrs, [:user_id, :token])
    |> validate_required([:user_id, :token])
  end
end
