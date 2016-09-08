defmodule Todo.TodoChannel do
  use Todo.Web, :channel
  alias Todo.{Todo, Todos, TodoView}

  def join("todos:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("todo:create", %{"todo" => todo_params}, socket) do
    case Todos.create(todo_params) do
      {:ok, %Todo{} = todo} ->
        json = TodoView.render("todo.json", %{todo: todo})
        broadcast socket, "todo:created", json
        {:noreply, socket}
      {:error, changeset} ->
        {:reply, {:error, changeset}, socket}
    end
  end

  def handle_in("todo:complete", %{"todo_id" => todo_id}, socket) do
    case Todos.complete(todo_id) do
      {:ok, %Todo{}} ->
        broadcast socket, "todo:completed", %{todoId: todo_id}
        {:noreply, socket}
      {:error, changeset} ->
        {:reply, {:error, changeset.errors}, socket}
    end
  end

  defp authorized?(_payload) do
    true
  end
end
