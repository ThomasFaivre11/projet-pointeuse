defmodule UsersApi.TeamManagement do
  @moduledoc """
  The TeamManagement context.
  """

  import Ecto.Query, warn: false
  alias UsersApi.Repo

  alias UsersApi.TeamManagement.WorkTeams

  @doc """
  Returns the list of workteams.

  ## Examples

      iex> list_workteams()
      [%WorkTeams{}, ...]

  """
  def list_workteams do
    Repo.all(WorkTeams)
  end

  @doc """
  Gets a single work_teams.

  Raises `Ecto.NoResultsError` if the Work teams does not exist.

  ## Examples

      iex> get_work_teams!(123)
      %WorkTeams{}

      iex> get_work_teams!(456)
      ** (Ecto.NoResultsError)

  """
  def get_work_teams!(id), do: Repo.get!(WorkTeams, id)

  @doc """
  Creates a work_teams.

  ## Examples

      iex> create_work_teams(%{field: value})
      {:ok, %WorkTeams{}}

      iex> create_work_teams(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_work_teams(attrs \\ %{}) do
    %WorkTeams{}
    |> WorkTeams.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a work_teams.

  ## Examples

      iex> update_work_teams(work_teams, %{field: new_value})
      {:ok, %WorkTeams{}}

      iex> update_work_teams(work_teams, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_work_teams(%WorkTeams{} = work_teams, attrs) do
    work_teams
    |> WorkTeams.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a work_teams.

  ## Examples

      iex> delete_work_teams(work_teams)
      {:ok, %WorkTeams{}}

      iex> delete_work_teams(work_teams)
      {:error, %Ecto.Changeset{}}

  """
  def delete_work_teams(%WorkTeams{} = work_teams) do
    Repo.delete(work_teams)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking work_teams changes.

  ## Examples

      iex> change_work_teams(work_teams)
      %Ecto.Changeset{data: %WorkTeams{}}

  """
  def change_work_teams(%WorkTeams{} = work_teams, attrs \\ %{}) do
    WorkTeams.changeset(work_teams, attrs)
  end

  @doc """
  Returns all members of a team
  """
  def get_by_manager_id(manager_id) do
    Repo.all(from wt in WorkTeams, where: wt.manager_id == ^manager_id)
  end


end
