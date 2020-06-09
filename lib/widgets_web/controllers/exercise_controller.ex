defmodule WidgetsWeb.ExerciseController do
  use WidgetsWeb, :controller

  alias Widgets.Exercises
  alias Widgets.Methods
  alias Widgets.Exercises.Exercise

  def index(conn, %{"method_id" => method_id}) do
    method = Methods.get_method!(String.to_integer(method_id))
    exercises = Exercises.list_exercises()
    render(conn, "index.html", method: method, exercises: exercises)
  end

  def new(conn, %{"method_id" => method_id}) do
    method = Methods.get_method!(String.to_integer(method_id))
    changeset = Exercises.change_exercise(%Exercise{method_id: method_id})
    render(conn, "new.html", method: method, changeset: changeset)
  end

  def create(conn, %{"method_id" => method_id, "exercise" => exercise_params}) do
    method = Methods.get_method!(String.to_integer(method_id))

    case Exercises.create_exercise(Map.merge(exercise_params, %{"method_id" => method_id})) do
      {:ok, exercise} ->
        conn
        |> put_flash(:info, "Exercise created successfully.")
        |> redirect(to: Routes.method_exercise_path(conn, :show, method_id, exercise))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", method: method, changeset: changeset)
    end
  end

  def show(conn, %{"method_id" => method_id, "id" => id}) do
    method = Methods.get_method!(String.to_integer(method_id))
    exercise = Exercises.get_exercise!(id)
    render(conn, "show.html", method: method, exercise: exercise)
  end

  def edit(conn, %{"method_id" => method_id, "id" => id}) do
    method = Methods.get_method!(String.to_integer(method_id))
    exercise = Exercises.get_exercise!(id)
    changeset = Exercises.change_exercise(exercise)
    render(conn, "edit.html", method: method, exercise: exercise, changeset: changeset)
  end

  def update(conn, %{"method_id" => method_id, "id" => id, "exercise" => exercise_params}) do
    method = Methods.get_method!(String.to_integer(method_id))
    exercise = Exercises.get_exercise!(id)

    case Exercises.update_exercise(
           exercise,
           Map.merge(exercise_params, %{"method_id" => method_id})
         ) do
      {:ok, exercise} ->
        conn
        |> put_flash(:info, "Exercise updated successfully.")
        |> redirect(to: Routes.method_exercise_path(conn, :show, method_id, exercise))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", method: method, exercise: exercise, changeset: changeset)
    end
  end

  def delete(conn, %{"method_id" => method_id, "id" => id}) do
    exercise = Exercises.get_exercise!(id)
    {:ok, _exercise} = Exercises.delete_exercise(exercise)

    conn
    |> put_flash(:info, "Exercise deleted successfully.")
    |> redirect(to: Routes.method_exercise_path(conn, :index, method_id))
  end
end
