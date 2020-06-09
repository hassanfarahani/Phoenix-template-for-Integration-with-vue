defmodule Widgets.Repo.Migrations.CreateMethods do
  use Ecto.Migration

  def change do
    create table(:methods) do
      add :name, :string

      timestamps()
    end
  end
end
