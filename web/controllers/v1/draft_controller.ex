defmodule HsDraft.V1.DraftController do
  use HsDraft.Web, :controller

  alias HsDraft.Draft
  alias HsDraft.Pick

  plug :scrub_params, "draft" when action in [:create, :update]

  def index(conn, _params) do
    drafts = Repo.all(Draft)
    render(conn, "index.json", drafts: drafts)
  end

  def create(conn, %{"draft" => draft_params}) do
    changeset = Draft.changeset(%Draft{}, draft_params)

    changeset = Ecto.Changeset.put_embed(changeset, :picks,
      [%Pick{active: false}]
    )

    case Repo.insert(changeset) do
      {:ok, draft} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_draft_path(conn, :show, draft))
        |> render("show.json", draft: draft)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HsDraft.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    draft = Repo.get!(Draft, id)
    render(conn, "show.json", draft: draft)
  end

  def update(conn, %{"id" => id, "draft" => draft_params}) do
    draft = Repo.get!(Draft, id)
    changeset = Draft.changeset(draft, draft_params)

    case Repo.update(changeset) do
      {:ok, draft} ->
        render(conn, "show.json", draft: draft)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HsDraft.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    draft = Repo.get!(Draft, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(draft)

    send_resp(conn, :no_content, "")
  end
end
