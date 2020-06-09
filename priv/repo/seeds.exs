# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Widgets.Repo.insert!(%Widgets.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Widgets.Methods
alias Widgets.Exercises

{:ok, rta} = Methods.create_method(%{name: "RTA"})

Exercises.create_exercise(%{
  name: "Ex. 1",
  description: "Problem to solve",
  method_id: rta.id,
  properties_display: """
  [
  {
  "expected_value": 2,
  "max": 5,
  "min": 0,
  "name": "porosity",
  "step": 0.1,
  "value": 1,
  "visible": true
  },
  {
  "expected_value": 4,
  "max": 10,
  "min": 0,
  "name": "viscosity",
  "step": 2,
  "value": 1,
  "visible": true
  },
  {
  "expected_value": 4,
  "max": 10,
  "min": 0,
  "name": "other",
  "step": 2,
  "value": 1,
  "visible": true
  }
  ]
  """
});
