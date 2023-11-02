defmodule UsersApi.TimesTest do
  use UsersApi.DataCase

  alias UsersApi.Times

  describe "workingtimes" do
    alias UsersApi.Times.Workingtime

    @valid_attrs %{start: ~N[2010-04-17 14:00:00], end: ~N[2010-04-17 14:00:00]}
    @update_attrs %{start: ~N[2011-05-18 15:01:01], end: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{start: nil, end: nil}

    def workingtime_fixture(attrs \\ %{}) do
      {:ok, workingtime} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Times.create_workingtime()

      workingtime
    end

    test "list_workingtimes/0 returns all workingtimes" do
      workingtime = workingtime_fixture()
      assert Times.list_workingtimes() == [workingtime]
    end

    test "get_workingtime!/1 returns the workingtime with given id" do
      workingtime = workingtime_fixture()
      assert Times.get_workingtime!(workingtime.id) == workingtime
    end

    test "create_workingtime/1 with valid data creates a workingtime" do
      assert {:ok, %Workingtime{} = workingtime} = Times.create_workingtime(@valid_attrs)
      assert workingtime.start == ~N[2010-04-17 14:00:00]
      assert workingtime.end == ~N[2010-04-17 14:00:00]
    end

    test "create_workingtime/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Times.create_workingtime(@invalid_attrs)
    end

    test "update_workingtime/2 with valid data updates the workingtime" do
      workingtime = workingtime_fixture()
      assert {:ok, %Workingtime{} = workingtime} = Times.update_workingtime(workingtime, @update_attrs)
      assert workingtime.start == ~N[2011-05-18 15:01:01]
      assert workingtime.end == ~N[2011-05-18 15:01:01]
    end

    test "update_workingtime/2 with invalid data returns error changeset" do
      workingtime = workingtime_fixture()
      assert {:error, %Ecto.Changeset{}} = Times.update_workingtime(workingtime, @invalid_attrs)
      assert workingtime == Times.get_workingtime!(workingtime.id)
    end

    test "delete_workingtime/1 deletes the workingtime" do
      workingtime = workingtime_fixture()
      assert {:ok, %Workingtime{}} = Times.delete_workingtime(workingtime)
      assert_raise Ecto.NoResultsError, fn -> Times.get_workingtime!(workingtime.id) end
    end

    test "change_workingtime/1 returns a workingtime changeset" do
      workingtime = workingtime_fixture()
      assert %Ecto.Changeset{} = Times.change_workingtime(workingtime)
    end
  end
end
