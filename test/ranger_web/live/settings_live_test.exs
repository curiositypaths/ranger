defmodule RangerWeb.SettingsLiveTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias Ranger.{Repo, User}

  test "renders user information", %{conn: conn} do
    user = create_user()

    {:ok, _view, html} = live(conn, ~p"/users/#{user}/settings")

    assert html =~ user.name
    assert html =~ user.email
  end

  test "user can edit name", %{conn: conn} do
    user = create_user(%{name: "original name"})

    {:ok, view, _html} = live(conn, ~p"/users/#{user}/settings")
    new_name = "new name"

    view
    |> element("#name")
    |> render_click()

    view
    |> form("#name-form", %{name: new_name})
    |> render_submit()

    assert has_element?(view, "#name", new_name)
  end

  test "user can edit email", %{conn: conn} do
    user = create_user(%{email: "original_address@example.com"})

    {:ok, view, _html} = live(conn, ~p"/users/#{user}/settings")
    new_email = "new_address@example.com"

    view
    |> element("#email")
    |> render_click()

    view
    |> form("#email-form", %{email: new_email})
    |> render_submit()

    assert has_element?(view, "#email", new_email)
  end

  defp create_user(params \\ %{}) do
    %{email: "random@example.com", name: "randomname"}
    |> Map.merge(params)
    |> User.changeset()
    |> Repo.insert!()
  end
end
