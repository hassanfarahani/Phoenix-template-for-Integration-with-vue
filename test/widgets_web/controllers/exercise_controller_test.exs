defmodule WidgetsWeb.ExerciseControllerTest do
  use WidgetsWeb.ConnCase

  alias Widgets.Exercises
  alias Widgets.Methods

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:exercise) do
    method = fixture(:method)
    {:ok, exercise} = Exercises.create_exercise(Map.merge(@create_attrs, %{method_id: method.id}))
    exercise
  end

  def fixture(:method) do
    {:ok, method} = Methods.create_method(%{name: "some name"})
    method
  end

  describe "index" do
    test "lists all exercises", %{conn: conn} do
      method = fixture(:method)
      conn = get(conn, Routes.method_exercise_path(conn, :index, method))
      assert html_response(conn, 200) =~ "Listing Exercises"
    end
  end

  describe "new exercise" do
    test "renders form", %{conn: conn} do
      method = fixture(:method)
      conn = get(conn, Routes.method_exercise_path(conn, :new, method))
      assert html_response(conn, 200) =~ "New Exercise"
    end
  end

  describe "create exercise" do
    test "redirects to show when data is valid", %{conn: conn} do
      method = fixture(:method)

      conn =
        post(conn, Routes.method_exercise_path(conn, :create, method), exercise: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.method_exercise_path(conn, :show, method, id)

      conn = get(conn, Routes.method_exercise_path(conn, :show, method, id))
      assert html_response(conn, 200) =~ "Show Exercise"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      method = fixture(:method)

      conn =
        post(conn, Routes.method_exercise_path(conn, :create, method), exercise: @invalid_attrs)

      assert html_response(conn, 200) =~ "New Exercise"
    end
  end

  describe "edit exercise" do
    setup [:create_exercise]

    test "renders form for editing chosen exercise", %{
      conn: conn,
      method: method,
      exercise: exercise
    } do
      conn = get(conn, Routes.method_exercise_path(conn, :edit, method, exercise))
      assert html_response(conn, 200) =~ "Edit Exercise"
    end
  end

  describe "update exercise" do
    setup [:create_exercise]

    test "redirects when data is valid", %{conn: conn, method: method, exercise: exercise} do
      conn =
        put(conn, Routes.method_exercise_path(conn, :update, method, exercise),
          exercise: @update_attrs
        )

      assert redirected_to(conn) == Routes.method_exercise_path(conn, :show, method, exercise)

      conn = get(conn, Routes.method_exercise_path(conn, :show, method, exercise))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, method: method, exercise: exercise} do
      conn =
        put(conn, Routes.method_exercise_path(conn, :update, method, exercise),
          exercise: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Exercise"
    end
  end

  describe "delete exercise" do
    setup [:create_exercise]

    test "deletes chosen exercise", %{conn: conn, method: method, exercise: exercise} do
      conn = delete(conn, Routes.method_exercise_path(conn, :delete, method, exercise))
      assert redirected_to(conn) == Routes.method_exercise_path(conn, :index, method)

      assert_error_sent 404, fn ->
        get(conn, Routes.method_exercise_path(conn, :show, method, exercise))
      end
    end
  end

  defp create_exercise(_) do
    exercise = fixture(:exercise)
    %{method: exercise.method_id, exercise: exercise}
  end
end
