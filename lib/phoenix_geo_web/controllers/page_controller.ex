defmodule PhoenixGeoWeb.PageController do
  use PhoenixGeoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
