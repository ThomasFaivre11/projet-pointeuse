defmodule UsersApiWeb.UserController do
  use UsersApiWeb, :controller
  alias UsersApi.Auth
  alias UsersApi.Auth.Guardian
  alias UsersApi.Admin
  alias UsersApi.Admin.User

  action_fallback UsersApiWeb.FallbackController

  def index(conn, _params) do
    users = Admin.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    case Admin.create_user(user_params) do
      {:ok, %User{} = user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.user_path(conn, :show, user))
        |> json(%{user: %{id: user.id, username: user.username, email: user.email}})
      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Failed to create user: #{reason}"})
    end
  end

  def show(conn, %{"id" => id}) do
    user = Admin.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def disconnect(conn, %{"token" => token}) do
    case Repo.get_by(UserToken, token: token) do
      nil ->
        send_resp(conn, :not_found, "Token not found")
      user_token ->
        case Repo.delete(user_token) do
          {:ok, _struct} ->
            send_resp(conn, :ok, "User disconnected")
          {:error, reason} ->
            send_resp(conn, :internal_server_error, "Internal server error: #{reason}")
        end
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Admin.get_user!(id)

    with {:ok, %User{} = user} <- Admin.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def filter(conn, %{"email" => email, "username" => username}) do
    users = Admin.get_users_by_email_and_username(email, username)
    render(conn, "index.json", users: users)
  end


  def login(conn, %{"email" => email, "password" => password}) do
    case Guardian.authenticate(email, password) do
      {:ok, user, token} ->
        conn
        |> put_status(:ok)
        |> json(%{user: user, token: token})
      {:error, :no_user} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "User not found"})
      {:error, :unauthorized} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid credentials"})
      {:error, _reason} ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "Internal server error"})
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Admin.get_user!(id)

    with {:ok, %User{}} <- Admin.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end


end
