defmodule UsersApiWeb.ClockController do
  use UsersApiWeb, :controller

  alias UsersApi.State
  alias UsersApi.State.Clock

  action_fallback UsersApiWeb.FallbackController

  def index(conn, %{"user_id" => user_id}) do
    clocks = State.Clock.get_clocks_by_user_id(user_id)
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"clocks" => clock_params}) do
    merged_params = Map.put(clock_params, "user_id", conn.params["user_id"])

    with {:ok, %Clock{} = clock} <- State.create_clock(merged_params) do
      conn
      |> put_status(:created)
      #|> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"id" => id}) do
    clock = State.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = State.get_clock!(id)

    with {:ok, %Clock{} = clock} <- State.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = State.get_clock!(id)

    with {:ok, %Clock{}} <- State.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end

  def delete_by_user_id(conn, %{"userID" => id}) do
    clock = State.get_clock_by_user_id(id)

    with {:ok, %Clock{}} <- State.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
