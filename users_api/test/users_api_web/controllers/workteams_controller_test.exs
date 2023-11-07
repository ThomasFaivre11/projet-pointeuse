defmodule UsersApiWeb.WorkteamsControllerTest do
  use UsersApiWeb.ConnCase

  alias UsersApi.TeamManagement
  alias UsersApi.TeamManagement.Workteams

  @create_attrs %{
    team_name: "some team_name"
  }
  @update_attrs %{
    team_name: "some updated team_name"
  }
  @invalid_attrs %{team_name: nil}

  def fixture(:workteams) do
    {:ok, workteams} = TeamManagement.create_workteams(@create_attrs)
    workteams
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all workteams", %{conn: conn} do
      conn = get(conn, Routes.workteams_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create workteams" do
    test "renders workteams when data is valid", %{conn: conn} do
      conn = post(conn, Routes.workteams_path(conn, :create), workteams: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.workteams_path(conn, :show, id))

      assert %{
               "id" => id,
               "team_name" => "some team_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.workteams_path(conn, :create), workteams: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update workteams" do
    setup [:create_workteams]

    test "renders workteams when data is valid", %{conn: conn, workteams: %Workteams{id: id} = workteams} do
      conn = put(conn, Routes.workteams_path(conn, :update, workteams), workteams: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.workteams_path(conn, :show, id))

      assert %{
               "id" => id,
               "team_name" => "some updated team_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, workteams: workteams} do
      conn = put(conn, Routes.workteams_path(conn, :update, workteams), workteams: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete workteams" do
    setup [:create_workteams]

    test "deletes chosen workteams", %{conn: conn, workteams: workteams} do
      conn = delete(conn, Routes.workteams_path(conn, :delete, workteams))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.workteams_path(conn, :show, workteams))
      end
    end
  end

  defp create_workteams(_) do
    workteams = fixture(:workteams)
    %{workteams: workteams}
  end
end
