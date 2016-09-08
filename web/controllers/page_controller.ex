defmodule Todo.PageController do
  use Todo.Web, :controller
  alias Todo.Todo

  def index(conn, _params) do
    todos =
      Todo
      |> Todo.completed
      |> Repo.all

    render conn, "index.html", %{todos: todos}
  end
end
