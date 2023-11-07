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

  defimpl Jason.Encoder, for: Tuple do
    def encode({:ok, value}, opts) do
      # Vous pouvez choisir de convertir la tuple en une structure JSON que vous souhaitez
      Jason.Encode.map(%{data: value}, opts)
    end

    def encode({:error, reason}, opts) do
      Jason.Encode.map(%{error: reason}, opts)
    end
  end


  def get_manager_id(conn, %{"token" => token}) do
    case get_manager_id_by_token(token) do
      nil ->
        conn
        |> send_resp(404, "Manager not found")
      manager_id ->
        conn
        |> send_resp(200, Jason.encode!(%{manager_id: manager_id}))
    end
  end

  def get_manager_id_by_token(token) do
    case Repo.get_by(UserToken, token: token) do
      nil -> {:error, :not_found}
      user_token -> {:ok, user_token.user_id}
    end
  end
end
