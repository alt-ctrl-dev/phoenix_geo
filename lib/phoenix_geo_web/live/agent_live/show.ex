defmodule PhoenixGeoWeb.AgentLive.Show do
  use PhoenixGeoWeb, :live_view

  alias PhoenixGeo.Rental

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:agent, Rental.get_agent!(id))}
  end

  defp page_title(:show), do: "Show Agent"
  defp page_title(:edit), do: "Edit Agent"
end
