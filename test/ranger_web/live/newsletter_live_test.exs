defmodule RangerWeb.NewsletterLiveTest do
  use RangerWeb.ConnCase

  import Phoenix.LiveViewTest

  test "warns user of invalid email as user types", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/newsletter")

    invalid_email = "not an email address"

    html =
      view
      |> form("#subscribe", %{subscription: %{email: invalid_email}})
      |> render_change()

    # ok to use html since the string "has invalid format" is unlikely
    # to be present otherwide on the page
    assert html =~ "has invalid format"
  end

  test "warns user of invalid email as user types (using event)", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/newsletter")

    invalid_email = "not an email address"

    html =
      view
      |> render_change("validate", %{subscription: %{email: invalid_email}})

    # ok to use html since the string "has invalid format" is unlikely
    # to be present otherwide on the page
    assert html =~ "has invalid format"
  end
end
