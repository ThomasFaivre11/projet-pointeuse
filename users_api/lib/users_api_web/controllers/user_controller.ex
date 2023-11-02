defmodule UsersApiWeb.UserController do
  use UsersApiWeb, :controller

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
        |> render("show.json", user: user)

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


  def delete(conn, %{"id" => id}) do
    user = Admin.get_user!(id)

    with {:ok, %User{}} <- Admin.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
