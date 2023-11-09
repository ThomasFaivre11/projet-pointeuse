defmodule UsersApi.Times do
  @moduledoc """
  The Times context.
  """

  import Ecto.Query, warn: false
  alias UsersApi.Repo

  alias UsersApi.Times.Workingtime

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%Workingtime{}, ...]

  """
  def list_workingtimes do
    Repo.all(Workingtime)
  end

  @doc """
  Gets a single workingtime.

  Raises `Ecto.NoResultsError` if the Workingtime does not exist.

  ## Examples

      iex> get_workingtime!(123)
      %Workingtime{}

      iex> get_workingtime!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workingtime!(id), do: Repo.get!(Workingtime, id)

  @doc """
  Creates a workingtime.

  ## Examples

      iex> create_workingtime(%{field: value})
      {:ok, %Workingtime{}}

      iex> create_workingtime(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workingtime(attrs \\ %{}) do
    %Workingtime{}
    |> Workingtime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a workingtime.

  ## Examples

      iex> update_workingtime(workingtime, %{field: new_value})
      {:ok, %Workingtime{}}

      iex> update_workingtime(workingtime, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workingtimes(id, attrs) when is_binary(id) do
    workingtime = Repo.get!(Workingtime, id)
    update_workingtime(workingtime, attrs)
  end

  def update_workingtime(%Workingtime{} = workingtime, attrs) do
    workingtime
    |> Workingtime.changeset(attrs)
    |> Repo.update()
  end
  @doc """
  Méthode ayant pour but de modifier la date de fin d'un workingtime en cours en fonction d'un user_id
    L'user_id doit figurer dans le body de la requête
  """
  def update_end(user_id, attrs) do
    workingtime = from(w in Workingtime, where: is_nil(w.end) and w.user_id == ^user_id, select: w)
    |> Repo.one()

    case workingtime do
      %Workingtime{} = workingtime ->
        workingtime
        |> Workingtime.changeset(attrs)
        |> Repo.update()

      nil ->
        {:error, "Aucun workingtime en cours trouvé avec ce user_id "}
    end
  end


  @doc """
  Deletes a workingtime.

  ## Examples

      iex> delete_workingtime(workingtime)
      {:ok, %Workingtime{}}

      iex> delete_workingtime(workingtime)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workingtime(%Workingtime{} = workingtime) do
    Repo.delete(workingtime)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workingtime changes.

  ## Examples

      iex> change_workingtime(workingtime)
      %Ecto.Changeset{data: %Workingtime{}}

  """
  def change_workingtime(%Workingtime{} = workingtime, attrs \\ %{}) do
    Workingtime.changeset(workingtime, attrs)
  end

  def get_workingtime_by_user(user_id) do
    (from(w in Workingtime, where: w.user_id == ^user_id))
    |> Repo.all()
  end

  def get_workingtime_between_start_end(user_id, wt_start, wt_end) do
    from(w in Workingtime,
      where: w.start <= ^wt_end and w.end >= ^wt_start and w.user_id == ^user_id)
    |> Repo.all()
  end

end
