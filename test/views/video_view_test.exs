defmodule GigalixirHelloworld.VideoViewTest do
  use GigalixirHelloworld.ConnCase, async: true
  import Phoenix.View

  alias GigalixirHelloworld.Video

  test "renders index.html", %{conn: conn} do
    videos = [%Video{id: "1", title: "dogs"},
              %Video{id: "2", title: "cats"}]

    content = render_to_string(GigalixirHelloworld.VideoView, "index.html", conn: conn, videos: videos)

    assert String.contains?(content, "Listing videos")
    for video <- videos do
      assert String.contains?(content, video.title)
    end
  end

  test "renders new.html", %{conn: conn} do
    changeset = Video.changeset(%Video{})
    categories = [{"cargs", 123}]

    content = render_to_string(GigalixirHelloworld.VideoView, "new.html", conn: conn, changeset: changeset, categories: categories)

    assert String.contains?(content, "New video")
  end
end
