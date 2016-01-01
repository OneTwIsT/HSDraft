defmodule HsDraft.DraftTest do
  use HsDraft.ModelCase

  alias HsDraft.Draft

  @valid_attrs %{finished: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Draft.changeset(%Draft{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Draft.changeset(%Draft{}, @invalid_attrs)
    refute changeset.valid?
  end
end
