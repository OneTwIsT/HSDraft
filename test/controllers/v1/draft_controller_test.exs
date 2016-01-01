defmodule HsDraft.V1.DraftControllerTest do
  use HsDraft.ConnCase

  alias HsDraft.Draft
  @valid_attrs %{finished: true}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_draft_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    draft = Repo.insert! %Draft{}
    conn = get conn, v1_draft_path(conn, :show, draft)
    assert json_response(conn, 200)["data"] == %{"id" => draft.id,
      "finished" => draft.finished}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_draft_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_draft_path(conn, :create), draft: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Draft, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_draft_path(conn, :create), draft: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    draft = Repo.insert! %Draft{}
    conn = put conn, v1_draft_path(conn, :update, draft), draft: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Draft, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    draft = Repo.insert! %Draft{}
    conn = put conn, v1_draft_path(conn, :update, draft), draft: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    draft = Repo.insert! %Draft{}
    conn = delete conn, v1_draft_path(conn, :delete, draft)
    assert response(conn, 204)
    refute Repo.get(Draft, draft.id)
  end
end
