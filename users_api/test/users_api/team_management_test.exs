defmodule UsersApi.TeamManagementTest do
  use UsersApi.DataCase

  alias UsersApi.TeamManagement

  describe "workteams" do
    alias UsersApi.TeamManagement.WorkTeams

    @valid_attrs %{team_name: "some team_name"}
    @update_attrs %{team_name: "some updated team_name"}
    @invalid_attrs %{team_name: nil}

    def work_teams_fixture(attrs \\ %{}) do
      {:ok, work_teams} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TeamManagement.create_work_teams()

      work_teams
    end

    test "list_workteams/0 returns all workteams" do
      work_teams = work_teams_fixture()
      assert TeamManagement.list_workteams() == [work_teams]
    end

    test "get_work_teams!/1 returns the work_teams with given id" do
      work_teams = work_teams_fixture()
      assert TeamManagement.get_work_teams!(work_teams.id) == work_teams
    end

    test "create_work_teams/1 with valid data creates a work_teams" do
      assert {:ok, %WorkTeams{} = work_teams} = TeamManagement.create_work_teams(@valid_attrs)
      assert work_teams.team_name == "some team_name"
    end

    test "create_work_teams/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TeamManagement.create_work_teams(@invalid_attrs)
    end

    test "update_work_teams/2 with valid data updates the work_teams" do
      work_teams = work_teams_fixture()
      assert {:ok, %WorkTeams{} = work_teams} = TeamManagement.update_work_teams(work_teams, @update_attrs)
      assert work_teams.team_name == "some updated team_name"
    end

    test "update_work_teams/2 with invalid data returns error changeset" do
      work_teams = work_teams_fixture()
      assert {:error, %Ecto.Changeset{}} = TeamManagement.update_work_teams(work_teams, @invalid_attrs)
      assert work_teams == TeamManagement.get_work_teams!(work_teams.id)
    end

    test "delete_work_teams/1 deletes the work_teams" do
      work_teams = work_teams_fixture()
      assert {:ok, %WorkTeams{}} = TeamManagement.delete_work_teams(work_teams)
      assert_raise Ecto.NoResultsError, fn -> TeamManagement.get_work_teams!(work_teams.id) end
    end

    test "change_work_teams/1 returns a work_teams changeset" do
      work_teams = work_teams_fixture()
      assert %Ecto.Changeset{} = TeamManagement.change_work_teams(work_teams)
    end
  end

  describe "workteams" do
    alias UsersApi.TeamManagement.Workteams

    @valid_attrs %{team_name: "some team_name"}
    @update_attrs %{team_name: "some updated team_name"}
    @invalid_attrs %{team_name: nil}

    def workteams_fixture(attrs \\ %{}) do
      {:ok, workteams} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TeamManagement.create_workteams()

      workteams
    end

    test "list_workteams/0 returns all workteams" do
      workteams = workteams_fixture()
      assert TeamManagement.list_workteams() == [workteams]
    end

    test "get_workteams!/1 returns the workteams with given id" do
      workteams = workteams_fixture()
      assert TeamManagement.get_workteams!(workteams.id) == workteams
    end

    test "create_workteams/1 with valid data creates a workteams" do
      assert {:ok, %Workteams{} = workteams} = TeamManagement.create_workteams(@valid_attrs)
      assert workteams.team_name == "some team_name"
    end

    test "create_workteams/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TeamManagement.create_workteams(@invalid_attrs)
    end

    test "update_workteams/2 with valid data updates the workteams" do
      workteams = workteams_fixture()
      assert {:ok, %Workteams{} = workteams} = TeamManagement.update_workteams(workteams, @update_attrs)
      assert workteams.team_name == "some updated team_name"
    end

    test "update_workteams/2 with invalid data returns error changeset" do
      workteams = workteams_fixture()
      assert {:error, %Ecto.Changeset{}} = TeamManagement.update_workteams(workteams, @invalid_attrs)
      assert workteams == TeamManagement.get_workteams!(workteams.id)
    end

    test "delete_workteams/1 deletes the workteams" do
      workteams = workteams_fixture()
      assert {:ok, %Workteams{}} = TeamManagement.delete_workteams(workteams)
      assert_raise Ecto.NoResultsError, fn -> TeamManagement.get_workteams!(workteams.id) end
    end

    test "change_workteams/1 returns a workteams changeset" do
      workteams = workteams_fixture()
      assert %Ecto.Changeset{} = TeamManagement.change_workteams(workteams)
    end
  end
end
