defmodule Widgets.Repo.Migrations.AddPropertiesToExercise do
  use Ecto.Migration

  def change do
    alter table(:exercises) do
      add :properties, {:array, :map}, []
    end
  end
end
