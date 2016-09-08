defmodule Todo.TodoChannelTest do
  use Todo.ChannelCase

  alias Todo.TodoChannel

  @valid_todo_params %{"name" => "Make an app"}
  @invalid_todo_params %{"hello" => "world"}
  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(TodoChannel, "todos:lobby")

    {:ok, socket: socket}
  end

  describe "todo:create" do
    @tag :skip
    test "replies with status ok", %{socket: socket} do
      ref = push socket, "todo:create", %{"todo" => @valid_todo_params}
      assert_reply ref, :ok
    end

    @tag :skip
    test "creates a new todo", %{socket: socket} do
      ref = push socket, "todo:create", %{"todo" => @valid_todo_params}
      assert_reply ref, :ok
      assert Repo.one(Todo.Todo).name == "Make an app"
    end

    @tag :skip
    test "replies with {error, changeset} on failure", %{socket: socket} do
      ref = push socket, "todo:create", %{"todo" => @invalid_todo_params}
      assert_reply ref, :error, %{}
    end
  end

  describe "todo:complete" do
    @tag :skip
    test "broadcasts on success", %{socket: socket} do
      {:ok, %Todo.Todo{id: id}} = Todo.Todos.create(@valid_todo_params)
      ref = push socket, "todo:complete", %{"todo_id" => id}
      assert_reply ref, :ok, %{}
      assert_broadcast "todo:completed", %{"todoId" => todo_id}
      assert todo_id == id
    end
  end
end
