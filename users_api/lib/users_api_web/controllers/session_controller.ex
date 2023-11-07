defmodule UsersApiWeb.SessionController do
  use UsersApiWeb, :controller

  alias UsersApi.Repo
  alias UsersApi.Accounts.UserToken

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
end
