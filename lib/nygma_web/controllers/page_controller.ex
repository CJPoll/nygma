defmodule NygmaWeb.PageController do
  use NygmaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
