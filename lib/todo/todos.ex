defmodule Todo.Todos do
  alias Todo.Repo

  def create(params) do
    %Todo.Todo{}
    |> Todo.Todo.changeset(params)
    |> Repo.insert
  end

  def complete(id) when is_integer(id) or is_binary(id) do
    todo = Repo.get(Todo.Todo, id)

    if todo, do: complete(todo), else: {:error, "No such todo"}
  end

  def complete(%Todo.Todo{} = todo) do
    todo
    |> Todo.Todo.changeset(%{completed: true})
    |> Repo.update
  end
end
