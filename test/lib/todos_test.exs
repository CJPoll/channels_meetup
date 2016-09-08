defmodule Todo.Todos.Test do
  use Todo.ModelCase
  alias Todo.Todos

  @valid_todo_params %{"name" => "Do Something"}
  @invalid_todo_params %{"name" => ""}

  describe "create" do
    test "exists" do
      Todos.create(@valid_todo_params)
    end

    @tag :skip
    test "returns {:ok, todo} on success" do
      assert {:ok, %Todo.Todo{}} = Todos.create(@valid_todo_params)
    end

    @tag :skip
    test "returns {:error, changeset} on failure" do
      assert {:error, %Ecto.Changeset{}} = Todos.create(@invalid_todo_params)
    end
  end

  describe "complete (accepting struct)" do
    @tag :skip
    test "exists" do
      Todos.complete(%Todo.Todo{})
    end

    @tag :skip
    test "returns {:ok, %Todo{}} on success" do
      {:ok, todo} = Todos.create(@valid_todo_params)
      assert {:ok, %Todo.Todo{}} = Todos.complete(todo)
    end
  end

  describe "complete (accepting binary or integer)" do
    @tag :skip
    test "accepts a binary id" do
      Todos.complete("1")
    end

    @tag :skip
    test "accepts an integer id" do
      Todos.complete(1)
    end

    @tag :skip
    test "returns {:error, \"No such todo\"} if todo is non-existent" do
      assert {:error, "No such todo"} = Todos.complete(1)
    end

    @tag :skip
    test "returns {:error, \"No such todo\"} if binary todo id is non-existent" do
      assert {:error, "No such todo"} = Todos.complete("1")
    end
  end
end
