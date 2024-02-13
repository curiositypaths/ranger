defmodule RangerWeb.AboutComponentsTest do
  use ExUnit.Case, async: true

  import Phoenix.Component
  import Phoenix.LiveViewTest

  import RangerWeb.AboutComponents

  describe "badge" do
    test "renders content in badge (render_component)" do
      component = render_component(&badge/1, type: "hobbit")

      assert component =~ "hobbit"
    end

    test "renders content in badge (HEEX)" do
      assigns = %{}

      # using ~H considered more idiomatic and it's simpler to test
      # nested components (i.e., slots)
      component =
        rendered_to_string(~H"""
        <.badge type="hobbit" />
        """)

      assert component =~ "hobbit"
    end
  end

  describe "card" do
    test "renderes title" do
      assigns = %{}

      title = "Title text"
      body = "body"

      component =
        rendered_to_string(~H"""
        <.card>
          <:title>
            <!-- idealy component should have a way to check if slot is properly rendered (semantic meaning) -->
            <%= title %>
          </:title>

          <div>
            <%= body %>
          </div>
        </.card>
        """)

      assert component =~ title
      assert component =~ body
    end
  end
end
