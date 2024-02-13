defmodule RangerWeb.DirectoryLiveTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias Ranger.Directory

  test "user id directed to member information", %{conn: conn} do
    member_name = "Frodo"
    member = Directory.get_by(name: member_name)
    {:ok, view, _html} = live(conn, ~p"/directory")

    view |> element("[data-role=member]", member_name) |> render_click()

    assert_patch(view, ~p"/directory/#{member.id}")
  end

  test "user can see member information when selected", %{conn: conn} do
    member_name = "Frodo"
    member = Directory.get_by(name: member_name)
    {:ok, view, _html} = live(conn, ~p"/directory")

    view |> element("[data-role=member]", member_name) |> render_click()

    # The below would test implementation detail (i.e., assumes patch)
    assert_patch(view, ~p"/directory/#{member.id}")
    assert has_element?(view, "#active-member", member_name)
  end

  test "can visit specific member", %{conn: conn} do
    member_name = "Frodo"
    member = Directory.get_by(name: member_name)
    {:ok, view, _html} = live(conn, ~p"/directory/#{member.id}")

    assert has_element?(view, "#active-member", member_name)
  end
end
