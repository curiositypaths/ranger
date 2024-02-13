defmodule RangerWeb.SettingsLive.EditableInputComponentTest do
  use RangerWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias RangerWeb.SettingsLive.EditableInputComponent

  test "renders field test" do
    user = %{name: "Some Name"}

    html = render_component(EditableInputComponent, id: "name", field: :name, user: user)

    assert html =~ user.name
  end
end
