defmodule GigalixirHelloworld.VideoControllerTest do
  use GigalixirHelloworld.ConnCase

  alias GigalixirHelloworld.Video
  @valid_attrs %{description: "some description", title: "some title", url: "some url"}
  @invalid_attrs %{}

  setup %{conn: conn} = config do
    if username = config[:login_as] do
      user = insert_user(username: username)
      conn = assign(conn, :current_user, user)
      {:ok, conn: conn, user: user}
    else
      :ok
    end
  end

  test "requires user authentication on all actions", %{conn: conn} do
    Enum.each([
      get(conn, video_path(conn, :new)),
      get(conn, video_path(conn, :index)),
      get(conn, video_path(conn, :show, "123")),
      get(conn, video_path(conn, :edit, "123")),
      put(conn, video_path(conn, :update, "123", %{})),
      post(conn, video_path(conn, :create, %{})),
      delete(conn, video_path(conn, :delete, "123")),
      ], fn conn ->
        assert html_response(conn, 404)
        assert conn.halted
      end)
  end

  @tag login_as: "max"
  test "lists all user's videos on index", %{conn: conn, user: user} do
    user_video = insert_video(user, title: "my video")
    other_video = insert_video(insert_user(username: "other"), title: "other video")

    conn = get conn, video_path(conn, :index)
    assert html_response(conn, 200) =~ ~r/Listing videos/
    assert String.contains?(conn.resp_body, user_video.title)
    refute String.contains?(conn.resp_body, other_video.title)
  end

  @tag login_as: "max"
  test "renders form for new resources", %{conn: conn} do
    conn = get conn, video_path(conn, :new)
    assert html_response(conn, 200) =~ "New video"
  end

  @tag login_as: "max"
  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, video_path(conn, :create), video: @valid_attrs
    video = Repo.get_by!(Video, @valid_attrs)
    assert redirected_to(conn) == video_path(conn, :show, video.id)
  end

  @tag login_as: "max"
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, video_path(conn, :create), video: @invalid_attrs
    assert html_response(conn, 200) =~ "New video"
  end

  @tag login_as: "max"
  test "shows chosen resource", %{conn: conn, user: user} do
    video = insert_video(user, name: "some video")
    conn = get conn, video_path(conn, :show, video)
    assert html_response(conn, 200) =~ "Show video"
  end

  @tag login_as: "max"
  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, video_path(conn, :show, -1)
    end
  end

  @tag login_as: "max"
  test "renders form for editing chosen resource", %{conn: conn, user: user} do
    video = insert_video(user, name: "some video")
    conn = get conn, video_path(conn, :edit, video)
    assert html_response(conn, 200) =~ "Edit video"
  end

  @tag login_as: "max"
  test "updates chosen resource and redirects when data is valid", %{conn: conn, user: user} do
    video = insert_video(user, name: "some video")
    conn = put conn, video_path(conn, :update, video), video: @valid_attrs
    assert redirected_to(conn) == video_path(conn, :show, video)
    assert Repo.get_by(Video, @valid_attrs)
  end

  @tag login_as: "max"
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, user: user} do
    video = insert_video(user, name: "some video")
    conn = put conn, video_path(conn, :update, video), video: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit video"
  end

  @tag login_as: "max"
  test "deletes chosen resource", %{conn: conn, user: user} do
    video = insert_video(user, name: "some video")
    conn = delete conn, video_path(conn, :delete, video)
    assert redirected_to(conn) == video_path(conn, :index)
    refute Repo.get(Video, video.id)
  end

  @tag login_as: "max"
  test "authorizes actions against access by other users", %{conn: conn, user: user} do
    video = insert_video(user, @valid_attrs)
    another_user = insert_user(username: "sneaky")
    conn = assign(conn, :current_user, another_user)

    assert_error_sent :not_found, fn ->
      get(conn, video_path(conn, :show, video))
    end
    assert_error_sent :not_found, fn ->
      get(conn, video_path(conn, :edit, video))
    end
    assert_error_sent :not_found, fn ->
      get(conn, video_path(conn, :update, video))
    end
    assert_error_sent :not_found, fn ->
      get(conn, video_path(conn, :delete, video))
    end
  end
end
