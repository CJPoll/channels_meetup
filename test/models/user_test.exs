defmodule Todo.UserTest do
  use Todo.ModelCase

  #alias Todo.User

  @valid_registration_params %{
    "email" => "cjpoll@gmail.com",
    "password" => "hello",
    "password_confirm" => "hello"
  }

  @unmatching_passwords %{
    "email" => "cjpoll@gmail.com",
    "password" => "hello",
    "password_confirm" => "hello_there"
  }

  @empty_password %{
    "email" => "cjpoll@gmail.com",
    "password" => "",
    "password_confirm" => ""
  }

  #test "has valid params" do
  #  cs = User.registration_changeset(@valid_registration_params)
  #  assert cs.errors == []
  #end

  #test "requires matching password_confirm" do
  #  cs = User.registration_changeset(@unmatching_passwords)
  #  assert cs.errors == [password_confirm: {"must match password", []}]
  #end

  #test "contains hashed password on successful validation" do
  #  cs = User.registration_changeset(@valid_registration_params)
  #  hashed_password = Ecto.Changeset.get_change(cs, :hashed_password)
  #  assert @valid_registration_params
  #         |> Map.get("password")
  #         |> Comeonin.Bcrypt.checkpw(hashed_password)
  #end

  #test "does not allow an empty password" do
  #  cs = User.registration_changeset(@empty_password)
  #  assert Keyword.get(cs.errors, :password) == {"can't be blank", []}
  #end
end
