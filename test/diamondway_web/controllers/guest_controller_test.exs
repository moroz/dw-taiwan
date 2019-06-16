defmodule DiamondwayWeb.GuestControllerTest do
  use DiamondwayWeb.ConnCase

  alias Diamondway.Guests

  @create_attrs %{city: "some city", country: "some country", email: "some email", first_name: "some first_name", last_name: "some last_name", reference_email: "some reference_email", reference_name: "some reference_name"}
  @update_attrs %{city: "some updated city", country: "some updated country", email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", reference_email: "some updated reference_email", reference_name: "some updated reference_name"}
  @invalid_attrs %{city: nil, country: nil, email: nil, first_name: nil, last_name: nil, reference_email: nil, reference_name: nil}

  def fixture(:guest) do
    {:ok, guest} = Guests.create_guest(@create_attrs)
    guest
  end

  describe "index" do
    test "lists all guests", %{conn: conn} do
      conn = get(conn, Routes.guest_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Guests"
    end
  end

  describe "new guest" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.guest_path(conn, :new))
      assert html_response(conn, 200) =~ "New Guest"
    end
  end

  describe "create guest" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.guest_path(conn, :create), guest: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.guest_path(conn, :show, id)

      conn = get(conn, Routes.guest_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Guest"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.guest_path(conn, :create), guest: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Guest"
    end
  end

  describe "edit guest" do
    setup [:create_guest]

    test "renders form for editing chosen guest", %{conn: conn, guest: guest} do
      conn = get(conn, Routes.guest_path(conn, :edit, guest))
      assert html_response(conn, 200) =~ "Edit Guest"
    end
  end

  describe "update guest" do
    setup [:create_guest]

    test "redirects when data is valid", %{conn: conn, guest: guest} do
      conn = put(conn, Routes.guest_path(conn, :update, guest), guest: @update_attrs)
      assert redirected_to(conn) == Routes.guest_path(conn, :show, guest)

      conn = get(conn, Routes.guest_path(conn, :show, guest))
      assert html_response(conn, 200) =~ "some updated city"
    end

    test "renders errors when data is invalid", %{conn: conn, guest: guest} do
      conn = put(conn, Routes.guest_path(conn, :update, guest), guest: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Guest"
    end
  end

  describe "delete guest" do
    setup [:create_guest]

    test "deletes chosen guest", %{conn: conn, guest: guest} do
      conn = delete(conn, Routes.guest_path(conn, :delete, guest))
      assert redirected_to(conn) == Routes.guest_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.guest_path(conn, :show, guest))
      end
    end
  end

  defp create_guest(_) do
    guest = fixture(:guest)
    {:ok, guest: guest}
  end
end
