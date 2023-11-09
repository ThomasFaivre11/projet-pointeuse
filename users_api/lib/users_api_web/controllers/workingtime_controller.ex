defmodule UsersApiWeb.WorkingtimeController do
  use UsersApiWeb, :controller

  alias UsersApi.Times
  alias UsersApi.Times.Workingtime

  action_fallback UsersApiWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Times.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"workingtime" => workingtime_params}) do
    user_id = conn.params["user_id"]
    merged_params = Map.put(workingtime_params, "user_id", user_id)

    with {:ok, %Workingtime{} = workingtime} <- Times.create_workingtime(merged_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end


  def show(conn, %{"id" => id}) do
    workingtime = Times.get_workingtime!(id)
    render(conn, "show.json", workingtime: workingtime)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    case UsersApi.Times.update_workingtimes(id, workingtime_params) do
      {:ok, workingtime} ->
        json(conn, %{"message" => "Updated successfully", "workingtime" => workingtime})
    end
  end

  def update_end(conn, %{"workingtime" => workingtime_params}) do
    case UsersApi.Times.update_end(workingtime_params["user_id"], workingtime_params) do
      {:ok, workingtime} ->
        json(conn, %{"message" => "Updated successfully", "workingtime" => workingtime})
      {:error, error_message} ->
        conn
        |> put_status(:bad_request)
        |> json(%{"error" => error_message})
    end
  end

  def delete(conn, %{"id" => id}) do
      workingtime = Times.get_workingtime!(id)
      with {:ok, %Workingtime{}} <- Times.delete_workingtime(workingtime) do
        send_resp(conn, :no_content, "")
      end
  end

  def filter_between(conn, %{"start" => wt_start, "end" => wt_end}) do
    workingtimes = Times.get_workingtime_between_start_end(conn.params["user_id"], wt_start, wt_end) || []
    render(conn, "index.json", workingtimes: workingtimes)
  end

end
