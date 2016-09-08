defmodule Todo.TodoChannelTest do
  use Todo.ChannelCase

  alias Todo.TodoChannel

  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(TodoChannel, "todos:lobby")

    {:ok, socket: socket}
  end

  #test "todo:create replies with status ok", %{socket: socket} do
  #  ref = push socket, "todo:create", %{"todo" => %{"name" => "Make an app"}}
  #  assert_reply ref, :ok, %{}
  #end

  #test "shout broadcasts to todo:lobby", %{socket: socket} do
  #  push socket, "shout", %{"hello" => "all"}
  #  assert_broadcast "shout", %{"hello" => "all"}
  #end

  #test "broadcasts are pushed to the client", %{socket: socket} do
  #  broadcast_from! socket, "broadcast", %{"some" => "data"}
  #  assert_push "broadcast", %{"some" => "data"}
  #end
end
