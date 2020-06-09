defmodule WidgetsWeb.ExerciseLive do
  use WidgetsWeb, :live_view

  def mount(_params ,%{} = session, socket) do
    {:ok, assign(socket, exercise: session["exercise"])}
  end

  def handle_event("update", %{
    "_target" => ["exercise", prop_name],
    "exercise" => new_values}, socket) do

    exercise = socket.assigns.exercise
    properties = exercise.properties
                 |> Enum.map(fn
                   %{"name" => ^prop_name} = prop ->
                     {new_value, ""} = Float.parse(new_values[prop_name])
                     %{ prop | "value" => new_value }
                   prop ->
                     prop
                 end)

    {:noreply, assign(socket, :exercise, %{exercise | properties: properties})}
  end

  def handle_event("validate", %{}, socket) do
    exercise = socket.assigns.exercise
    properties = exercise.properties

    complete = Enum.all?(properties, fn (prop) -> prop["expected_value"] ==  prop["value"] end)

    {:noreply, assign(socket, :exercise, %{exercise | complete: complete})}
  end
end
