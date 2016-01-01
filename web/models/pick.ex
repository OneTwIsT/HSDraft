defmodule HsDraft.Pick do
  use HsDraft.Web, :model
  alias HsDraft.PickOption

  embedded_schema do
    field :active, :boolean, default: false
    embeds_many :cards, PickOption
  end

  @required_fields ~w()
  @optional_fields ~w(active)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end