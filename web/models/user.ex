defmodule Todo.User do
  use Todo.Web, :model

  @registration_fields [:email, :password, :password_confirm]

  @type t :: %__MODULE__{}
  schema "users" do
    field :email, :string
    field :hashed_password, :string
    field :password, :string, virtual: true
    field :password_confirm, :string, virtual: true

    timestamps()
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @registration_fields)
    |> validate_required(@registration_fields)
    |> unique_constraint(:email)
    |> validate_password_confirmation
    |> hash_password
  end

  def with_email(query, email) do
    from u in query,
      where: u.email == ^email
  end

  def matches_password?(%__MODULE__{hashed_password: hashed_password}, password) do
    Comeonin.Bcrypt.checkpw(password, hashed_password)
  end

  defp hash_password(%Ecto.Changeset{errors: []} = changeset) do
    hashed_password =
      changeset |> get_change(:password)
      |> Comeonin.Bcrypt.hashpwsalt

    put_change(changeset, :hashed_password, hashed_password)
  end

  defp hash_password(%Ecto.Changeset{} = changeset), do: changeset

  defp validate_password_confirmation(%Ecto.Changeset{} = changeset) do
    if get_change(changeset, :password) == get_change(changeset, :password_confirm) do
      changeset
    else
      add_error(changeset, :password_confirm, "must match password")
    end
  end
end
