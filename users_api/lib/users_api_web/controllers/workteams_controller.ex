defmodule UsersApiWeb.WorkteamsController do
  use UsersApiWeb, :controller

  alias UsersApi.TeamManagement
  alias UsersApi.TeamManagement.WorkTeams

  action_fallback UsersApiWeb.FallbackController

  def index(conn, _params) do
    workteams = TeamManagement.list_workteams()
    render(conn, "index.json", workteams: workteams)
  end

  def create(conn, %{"workteams" => workteams_params}) do
    with {:ok, %WorkTeams{} = workteams} <- TeamManagement.create_work_teams(workteams_params) do
      conn
      |> put_status(:created)
      #|> put_resp_header("location", Routes.workteams_path(conn, :show, workteams))
      |> render("show.json", workteams: workteams)
    end
  end

  def show(conn, %{"id" => id}) do
    workteams = TeamManagement.get_work_teams!(id)
    render(conn, "show.json", workteams: workteams)
  end

  def update(conn, %{"id" => id, "workteams" => workteams_params}) do
    workteams = TeamManagement.get_work_teams!(id)

    with {:ok, %WorkTeams{} = workteams} <- TeamManagement.update_work_teams(workteams, workteams_params) do
      render(conn, "show.json", workteams: workteams)
    end
  end

  def delete(conn, %{"id" => id}) do
    workteams = TeamManagement.get_work_teams!(id)
    with {:ok, %WorkTeams{}} <- TeamManagement.delete_work_teams(workteams) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_by_manager_id(conn, %{"manager_id" => manager_id}) do
    workteams = TeamManagement.get_by_manager_id(manager_id)
    render(conn, "index.json", workteams: workteams)
  end
end
