defmodule RangerWeb.CounterLiveTest do
  use RangerWeb.ConnCase

  import Phoenix.LiveViewTest

  test "user can increase counter", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/counter")

    view
    |> element("#increment")
    |> render_click()

    assert has_element?(view, "#count", "1")
  end

  test "user can increase counter (uses HTML)", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/counter")

    html =
      view
      |> element("#increment")
      |> render_click()

    # generic to an extent that the test will be very very brittle
    # (e.g., h1 tag will pass the assertion)
    assert html =~ "1"
  end

  test "user can increase counter (target event directly)", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/counter")

    html =
      view
      # Generates the event directly and skips the interaction with the UI
      # defeating the objective of the test (i.e., functionality works when
      # user interacts with the UI)
      |> render_click("increase")

    assert has_element?(view, "#count", "1")
  end

  test "user can decrement counter", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/counter")

    view
    |> element("#decrement")
    |> render_click()

    assert has_element?(view, "#count", "-1")
  end

  # test "user tries to decrement counter but element has wrong event", %{conn: conn} do
  #   {:ok, view, _html} = live(conn, ~p"/counter")

  #   view
  #   |> element("#broken_decrement")
  #   |> render_click()

  #   # assertion fails since the wrong event did not trigger the expected state update
  #   assert has_element?(view, "#count", "-1")
  # end

  # test "user tries to decrement counter with element emetting unhandled event", %{conn: conn} do
  #   {:ok, view, _html} = live(conn, ~p"/counter")

  #   view
  #   |> element("#unhandled_decrement")
  #   # Will generate the exception below
  #   # ** (FunctionClauseError) no function clause matching in RangerWeb.CounterLive.handle_event/3
  #   |> render_click()

  #   # LV will crash before we reach assertion
  #   assert true
  # end
end
