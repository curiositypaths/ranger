defmodule RangerWeb.DashboardLiveTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  describe "Navigates to homepage (outside live session)" do
    test "when clicking Testing LiveView (error tuple) ", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/dashboard")

      # show how liveview handles navigation outside live session
      {:error, {:redirect, %{to: path}}} =
        view
        |> element("#logo")
        |> render_click()

      assert path === "/"
    end
  end

  test "when clicking Testing LiveView (assert_redirect)", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/dashboard")

    view
    |> element("#logo")
    |> render_click()

    # could assert flash if relevant
    {path, _flash} = assert_redirect(view)

    assert path === ~p"/"
  end

  test "when clicking Testing LiveView (follow redirect)", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/dashboard")

    # we are not outside a live view
    {:ok, conn} =
      view
      |> element("#logo")
      |> render_click()
      |> follow_redirect(conn, ~p"/")

    html = html_response(conn, 200)

    # string is split across two assertions since they are in separate HTML elements
    assert html =~ "Testing"
    assert html =~ "LiveView"
  end

  describe "Navigates to another LiveView (inside same session)" do
    test "when clicking Team (error tuple)", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/dashboard")

      # show how liveview handles navigation outside live session
      # :live_redirect could be ingnore if we are testing only the redirect outcome
      # vs. the strategy
      #  {:error, {_redirect, %{to: path}}} =
      {:error, {:live_redirect, %{to: path}}} =
        view
        |> element("[data-role=page-link]", "Team")
        |> render_click()

      assert path === ~p"/team"
    end

    test "when clicking Team (assert_redirect)", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/dashboard")

      view
      |> element("[data-role=page-link]", "Team")
      |> render_click()

      # could assert flash if relevant
      {path, _flash} = assert_redirect(view)

      assert path === ~p"/team"
    end

    test "when clicking Team (follow redirect)", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/dashboard")

      # we are not outside a live view
      {:ok, _team_view, team_html} =
        view
        |> element("[data-role=page-link]", "Team")
        |> render_click()
        |> follow_redirect(conn, ~p"/team")

      assert team_html =~ "Team"
    end
  end
end
