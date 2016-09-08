defmodule Todo.Todo do
  use Todo.Web, :model

  schema "todos" do
    field :name, :string
    field :completed, :boolean

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :completed])
    |> validate_required([:name])
  end

  def completed(query) do
    from t in Todo.Todo,
      where: t.completed == false
  end
end
