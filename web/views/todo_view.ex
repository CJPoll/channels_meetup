defmodule Todo.TodoView do
  use Todo.Web, :view
  alias Todo.Todo

  def render("todo.json", %{todo: %Todo{} = todo}) do
    %{name: todo.name, completed: todo.completed, id: todo.id}
  end
end
