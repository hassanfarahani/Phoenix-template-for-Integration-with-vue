defmodule Widgets.Exercises.Exercise do
  use Ecto.Schema
  import Ecto.Changeset

  alias Widgets.Methods.Method

  schema "exercises" do
    field :description, :string
    field :name, :string
    field :properties, {:array, :map}
    field :properties_display, :string, virtual: true
    field :complete, :boolean, default: false, virtual: true

    belongs_to :method, Method

    timestamps()
  end

  @doc false
  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, [:name, :description, :method_id, :properties_display])
    |> validate_properties_display()
    |> validate_required([:name, :description])
    |> put_properties()
  end

  defp validate_properties_display(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{properties_display: properties_display}} ->
        case Jason.decode(properties_display) do
          {:ok, value} ->
            if is_list(value) do
              changeset
            else
              Ecto.Changeset.add_error(
                changeset,
                :properties_display,
                "invalid array of objects definition [{},{}]"
              )
            end

          {:error, _reason} ->
            Ecto.Changeset.add_error(
              changeset,
              :properties_display,
              "invalid array of objects definition [{},{}]"
            )
        end

      _ ->
        changeset
    end
  end

  defp put_properties(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{properties_display: properties_display}} ->
        put_change(changeset, :properties, Jason.decode!(properties_display))

      _ ->
        changeset
    end
  end
end
