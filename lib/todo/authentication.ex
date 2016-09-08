defmodule Todo.Authentication do
  @type email :: String.t
  @type password :: String.t

  alias Todo.User
  alias Todo.Repo

  defdelegate matches_password?(user, password), to: User

  @spec register(%{email: email, password: password, password_confirm: password})
  :: {:ok, User.t}
  |  {:error, Ecto.Changeset.t}
  def register(user_params) do
    %User{}
    |> User.registration_changeset(user_params)
    |> Repo.insert
  end

  def find_with_password(email, password) do
    result =
      User
      |> User.with_email(email)
      |> Repo.one

    case result do
      nil -> nil
      %User{} = user ->
        if matches_password?(user, password), do: user, else: nil
    end
  end
end
