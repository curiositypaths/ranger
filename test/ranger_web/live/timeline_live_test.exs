defmodule RangerWeb.TimelineLiveTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias Ranger.Timeline

  # Warning: test does not actually interact with the JS code.
  # If the JS implements core functionality consider E2E test
  test "user can see older posts with infinite scroll", %{conn: conn} do
    [post] = Timeline.posts(offset: 10, limit: 1)
    {:ok, view, _html} = live(conn, ~p"/timeline")

    view |> element("#load-more", "Loading ...") |> render_hook("load-more")

    assert has_element?(view, "[data-role=author]", post.author)
    assert has_element?(view, "[data-role=post]", post.text)
  end
end
