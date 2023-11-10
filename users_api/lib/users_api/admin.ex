defmodule UsersApi.Admin do
  @moduledoc """
  The Admin context.
  """
  import Ecto.Query, warn: false
  alias UsersApi.Repo
  alias UsersApi.Accounts.UserToken
  alias UsersApi.Auth.Guardian
  alias UsersApi.Admin.User
  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Get a single Account

  Return nil if the account does not exist.

  ## Examples

      iex> get_account_by_email(test@gmail.com)
      %User{}

      iex> get_account_by_email(no_account@gmail.com)
      nil
  """

  def get_account_by_username(username) do
    User
    |> where(username: ^username)
    |> Repo.one()
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def get_users_by_email_and_username(email, username) do
    from(u in User, where: u.email == ^email and u.username == ^username)
    |> Repo.all()
  end

  def get_account_by_email(email) do
    User
    |> where(email: ^email)
    |> Repo.one()
  end

  def delete_user_tokens(user_id) do
    from(ut in UsersApi.Accounts.UserToken, where: ut.user_id == ^user_id)
    |> Repo.delete_all()
  end


  def delete_user(user_id) do
    from(ut in UsersApi.Admin.User, where: ut.id == ^user_id)
    |> Repo.delete_all()
  end

end
