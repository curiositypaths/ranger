defmodule RangerWeb.TodoLiveTest do
  use RangerWeb.ConnCase

  import Phoenix.LiveViewTest

  test "user can create a new todo (rendering submit)", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/todo")

    todo_body = "My first todo"

    view
    |> form("#add-todo", %{todo: %{body: todo_body}})
    # test will pass even if create (i.e., submit )button is removed
    |> render_submit()

    # ensure create todo button is present since we are testing by
    # triggering the submit event
    assert has_element?(view, "form > * button")

    assert has_element?(view, "[data-role=todo]", todo_body)
  end

  test "user can create a new todo (target event without UI interaction)", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/todo")

    todo_body = "My first todo"

    view
    |> render_submit("create", %{todo: %{body: todo_body}})

    assert has_element?(view, "[data-role=todo]", todo_body)
  end

  test "user can create a new todo (using HTML)", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/todo")

    todo_body = "My first todo"

    html =
      view
      |> render_submit("create", %{todo: %{body: todo_body}})

    # brittle assertion since it could if the submission fails and the input is not cleared
    assert html =~ todo_body
  end

  # test "simulate how testing html alone can lead to false positive", %{conn: conn} do
  #   {:ok, view, _html} = live(conn, ~p"/todo")

  #   # will fail length validation
  #   todo_body_that_fails_length_validation = "to short"

  #   html =
  #     view
  #     |> render_submit("create", %{todo: %{body: todo_body_that_fails_length_validation}})

  #   # brittle assertion since it could if the submission fails and the input is not cleared
  #   assert html =~ todo_body_that_fails_length_validation
  # end
end
