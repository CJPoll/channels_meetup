defmodule Todo.Repo.Migrations.CreateTodo do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :name, :string
      add :owner_id, references(:users, on_delete: :delete_all)
      add :completed, :boolean, default: false

      timestamps()
    end

    create index(:todos, [:owner_id])
  end
end
