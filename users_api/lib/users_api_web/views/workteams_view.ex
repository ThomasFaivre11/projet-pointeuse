defmodule UsersApiWeb.WorkteamsView do
  use UsersApiWeb, :view
  alias UsersApiWeb.WorkteamsView

  def render("index.json", %{workteams: workteams}) do
    %{data: render_many(workteams, WorkteamsView, "workteams.json")}
  end

  def render("show.json", %{workteams: workteams}) do
    %{data: render_one(workteams, WorkteamsView, "workteams.json")}
  end

  def render("workteams.json", %{workteams: workteams}) do
    %{id: workteams.id,
      team_name: workteams.team_name}
  end
end
