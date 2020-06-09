defmodule Widgets.MethodsTest do
  use Widgets.DataCase

  alias Widgets.Methods

  describe "methods" do
    alias Widgets.Methods.Method

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def method_fixture(attrs \\ %{}) do
      {:ok, method} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Methods.create_method()

      method
    end

    test "list_methods/0 returns all methods" do
      method = method_fixture()
      assert Methods.list_methods() == [method]
    end

    test "get_method!/1 returns the method with given id" do
      method = method_fixture()
      assert Methods.get_method!(method.id) == method
    end

    test "create_method/1 with valid data creates a method" do
      assert {:ok, %Method{} = method} = Methods.create_method(@valid_attrs)
      assert method.name == "some name"
    end

    test "create_method/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Methods.create_method(@invalid_attrs)
    end

    test "update_method/2 with valid data updates the method" do
      method = method_fixture()
      assert {:ok, %Method{} = method} = Methods.update_method(method, @update_attrs)
      assert method.name == "some updated name"
    end

    test "update_method/2 with invalid data returns error changeset" do
      method = method_fixture()
      assert {:error, %Ecto.Changeset{}} = Methods.update_method(method, @invalid_attrs)
      assert method == Methods.get_method!(method.id)
    end

    test "delete_method/1 deletes the method" do
      method = method_fixture()
      assert {:ok, %Method{}} = Methods.delete_method(method)
      assert_raise Ecto.NoResultsError, fn -> Methods.get_method!(method.id) end
    end

    test "change_method/1 returns a method changeset" do
      method = method_fixture()
      assert %Ecto.Changeset{} = Methods.change_method(method)
    end
  end
end
