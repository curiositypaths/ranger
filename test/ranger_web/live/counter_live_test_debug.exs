defmodule RangerWeb.CounterLiveTest do
  use RangerWeb.ConnCase

  import Phoenix.LiveViewTest

  # Open view in browser to debug
  # test "user can increase counter", %{conn: conn} do
  #   {:ok, view, _html} = live(conn, ~p"/counter")

  #   # before increment
  #   open_browser(view)

  #   view
  #   |> element("#increment")
  #   # open browser to display single element
  #   |> open_browser()
  #   |> render_click()

  #   # afte increment
  #   open_browser(view)

  #   assert has_element?(view, "#count", "1")
  # end
end
