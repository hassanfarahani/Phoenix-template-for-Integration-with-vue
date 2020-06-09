defmodule Widgets.Repo.Migrations.CreateExercises do
  use Ecto.Migration

  def change do
    create table(:exercises) do
      add :name, :string
      add :description, :text
      add :method_id, references(:methods, on_delete: :nothing)

      timestamps()
    end

    create index(:exercises, [:method_id])
  end
end
