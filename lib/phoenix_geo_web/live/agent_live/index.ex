defmodule PhoenixGeoWeb.AgentLive.Index do
  use PhoenixGeoWeb, :live_view

  alias PhoenixGeo.Rental
  alias PhoenixGeo.Rental.Agent

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket, :agents, list_agents())
     |> assign(:starring, [])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Agent")
    |> assign(:agent, Rental.get_agent!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Agent")
    |> assign(:agent, %Agent{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Agents")
    |> assign(:agent, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    agent = Rental.get_agent!(id)
    {:ok, _} = Rental.delete_agent(agent)

    {:noreply, assign(socket, :agents, list_agents())}
  end

  @impl true
  def handle_event("toggle-favourite", %{"id" => id}, socket) do
    socket =
      socket
      |> assign(:starring, [id | socket.assigns.starring])

    Process.send_after(self(), {:update_favourite, id}, 500)
    {:noreply, socket}
  end

  @impl true
  def handle_info({:update_favourite, id}, socket) do
    agent = Rental.get_agent!(id)

    socket =
      case Rental.update_agent(agent, %{favourite: !agent.favourite}) do
        {:ok, _agent} ->
          assign(socket, :agents, list_agents())

        {:error, error} ->
          IO.inspect(error, label: "error")
          socket |> put_flash(:error, "Could not mark favourite")
      end

    starring = List.delete(socket.assigns.starring, id)

    socket =
      socket
      |> assign(:starring, starring)

    {:noreply, socket}
  end

  defp list_agents do
    Rental.list_agents()
  end
end
