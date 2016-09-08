defmodule Todo.TodoChannel do
  use Todo.Web, :channel

  def join("todos:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("todo:event", %{"todo" => _todo_params}, _socket) do
  end

  defp authorized?(_payload) do
    true
  end
end
