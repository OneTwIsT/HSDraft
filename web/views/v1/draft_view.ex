defmodule HsDraft.V1.DraftView do
  use HsDraft.Web, :view

  def render("index.json", %{drafts: drafts}) do
    %{data: render_many(drafts, HsDraft.V1.DraftView, "draft.json")}
  end

  def render("show.json", %{draft: draft}) do
    %{data: render_one(draft, HsDraft.V1.DraftView, "draft.json")}
  end

  def render("draft.json", %{draft: draft}) do
    %{id: draft.id,
      finished: draft.finished,
      picks: render_many(draft.picks, HsDraft.V1.PickView, "pick.json")}
  end
end
