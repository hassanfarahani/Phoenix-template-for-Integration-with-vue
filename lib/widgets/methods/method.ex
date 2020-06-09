defmodule Widgets.Methods.Method do
  use Ecto.Schema
  import Ecto.Changeset

  schema "methods" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(method, attrs) do
    method
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
