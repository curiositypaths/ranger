defmodule RangerWeb.GreetLiveTest do
  use RangerWeb.ConnCase

  import Phoenix.LiveViewTest

  test "renders disconnected state", testing_ds do
    # Result of
    # IO.inspect(testing_ds, pretty: true)
    #
    # %{
    #   async: false,
    #   line: 6,
    #   module: RangerWeb.GreetLiveTest,
    #   registered: %{},
    #   file: "/Users/jason/code/learning/elixir/live_view/ranger-lv-testing-course/test/ranger_web/live/greet_live_test.exs",
    #   case: RangerWeb.GreetLiveTest,
    #   test: :"test renders disconnected state",
    #   conn: %Plug.Conn{
    #     adapter: {Plug.Adapters.Test.Conn, :...},
    #     assigns: %{},
    #     body_params: %Plug.Conn.Unfetched{aspect: :body_params},
    #     cookies: %Plug.Conn.Unfetched{aspect: :cookies},
    #     halted: false,
    #     host: "www.example.com",
    #     method: "GET",
    #     owner: #PID<0.412.0>,
    #     params: %Plug.Conn.Unfetched{aspect: :params},
    #     path_info: [],
    #     path_params: %{},
    #     port: 80,
    #     private: %{plug_skip_csrf_protection: true, phoenix_recycled: true},
    #     query_params: %Plug.Conn.Unfetched{aspect: :query_params},
    #     query_string: "",
    #     remote_ip: {127, 0, 0, 1},
    #     req_cookies: %Plug.Conn.Unfetched{aspect: :cookies},
    #     req_headers: [],
    #     request_path: "/",
    #     resp_body: nil,
    #     resp_cookies: %{},
    #     resp_headers: [{"cache-control", "max-age=0, private, must-revalidate"}],
    #     scheme: :http,
    #     script_name: [],
    #     secret_key_base: nil,
    #     state: :unset,
    #     status: nil
    #   },
    #   describe: nil,
    #   describe_line: nil,
    #   test_type: :test
    # }
    disconnecte_state = get(testing_ds.conn, ~p"/greet")

    assert html_response(disconnecte_state, 200) =~ "Welcome to stateless HTTP"
  end

  test "upgrades connection", %{conn: conn} do
    disconnecte_state = get(conn, ~p"/greet")
    {:ok, _view, html} = live(disconnecte_state)

    assert html =~ "Welcome to Testing LiveView"
  end

  test "rendering connected state", %{conn: conn} do
    # Returns directly the connected state
    {:ok, _view, html} = live(conn, ~p"/greet")

    assert html =~ "Welcome to Testing LiveView"
  end

  test "rendering with the view", %{conn: conn} do
    # Returns directly the connected state
    {:ok, view, _html} = live(conn, ~p"/greet")

    # Result of
    # IO.inspect(view, pretty: true)
    #
    # #Phoenix.LiveViewTest.View<
    #   id: "phx-F7LuwOcsPS8HewBE",
    #   module: RangerWeb.GreetLive,
    #   pid: #PID<0.403.0>,
    #   endpoint: RangerWeb.Endpoint,
    #   ...
    # >

    assert view.module === RangerWeb.GreetLive
    assert is_pid(view.pid)
    assert render(view) =~ "Welcome to Testing LiveView"
  end
end
