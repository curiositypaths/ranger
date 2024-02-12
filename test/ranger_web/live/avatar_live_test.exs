defmodule RangerWeb.AvatarLiveTest do
  use RangerWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Ranger.Gravatar

  test "renders avatar for a given email", %{conn: conn} do
    email = "ranger@local.dev"
    avatar_url = Gravatar.generate(email)

    {:ok, _view, html} = live(conn, ~p"/avatar/#{email}")

    assert html =~ avatar_url
  end

  test "renders avatar HTML (testing implementation details)", %{conn: conn} do
    email = "ranger@local.dev"
    avatar_url = Gravatar.generate(email)

    {:ok, _view, html} = live(conn, ~p"/avatar/#{email}")

    avatar = ~s(<img class="avatar" src="#{avatar_url}")

    assert html =~ avatar
  end

  test "renders avatar image for a given email", %{conn: conn} do
    email = "ranger@local.dev"
    avatar_url = Gravatar.generate(email)

    {:ok, view, _html} = live(conn, ~p"/avatar/#{email}")

    assert has_element?(view, ~s(img[src*="#{avatar_url}"]))
  end

  test "renders avatar element for a given email", %{conn: conn} do
    email = "ranger@local.dev"
    avatar_url = Gravatar.generate(email)

    {:ok, view, _html} = live(conn, ~p"/avatar/#{email}")

    # conveys what (img[src*="#{avatar_url}"] is
    avatar = element(view, ~s(img[src*="#{avatar_url}"]))

    # IO.inspect(avatar, pretty: true)
    # RangerWeb.AvatarLiveTest [test/ranger_web/live/avatar_live_test.exs]
    #   * test renders avatar element for a given email [L#37]#Phoenix.LiveViewTest.Element<
    #   selector: "img[src*=\"https://www.gravatar.com/avatar/4e58776a6d547d273840b39a3495c1fd?d=https%3A%2F%2Fui-avatars.com%2Fapi%2Franger\"]",
    #   text_filter: nil,
    #   ...
    # >

    assert has_element?(avatar)
  end
end
