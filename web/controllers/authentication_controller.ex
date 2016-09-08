defmodule Todo.Authentication.Controller do
  use Todo.Web, :controller

  alias Todo.Authentication

  def register(conn, %{"user" => user_params}) do
    case Authentication.register(user_params) do
      {:ok, %Todo.User{} = user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: "/")
      {:error, changeset} ->
        errors =
          Enum.reduce(changeset.errors, [], fn({field, {message, _list}}, errors) ->
            message = "#{field |> Atom.to_string |> String.capitalize} #{message}"
            [message | errors]
          end)
          |> Enum.reverse
          |> Enum.join(" | ")

        conn
        |> put_flash(:error, errors)
        |> render("login.html")
    end
  end

  def authenticate(conn, %{"user" => %{"email" => email, "password" => password}}) do
    IO.inspect("authenticating")
    case Authentication.find_with_password(email, password) do
      nil ->
        conn
        |> put_flash(:error, "Invalid Credentials")
        |> render("login.html")

      user ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: "/")
    end
  end

  def login(conn, _params) do
    conn
    |> render("login.html")
  end
end
