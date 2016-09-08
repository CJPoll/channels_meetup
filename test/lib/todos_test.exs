defmodule Todo.Todos.Test do
  use Todo.ModelCase
  alias Todo.Todos

  @valid_todo_params %{"name" => "Do Something"}

  describe "create" do
    test "returns {:ok, _todo} on success" do
      assert {:ok, %Todo.Todo{}} = Todos.create(@valid_todo_params)
    end
  end
end
