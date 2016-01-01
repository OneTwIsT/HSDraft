defmodule HsDraft.V1.PickView do
  use HsDraft.Web, :view

  def render("index.json", %{picks: picks}) do
    %{data: render_many(picks, HsDraft.V1.pickView, "pick.json")}
  end

  def render("show.json", %{pick: pick}) do
    %{data: render_one(pick, HsDraft.V1.pickView, "pick.json")}
  end

  def render("pick.json", %{pick: pick}) do
    %{active: pick.active}
    # picks: pick.cards}
  end
end
