defmodule PhoenixGeoWeb.AgentLive.FormComponent do
  use PhoenixGeoWeb, :live_component

  alias PhoenixGeo.Rental

  @impl true
  def update(%{agent: agent} = assigns, socket) do
    changeset = Rental.change_agent(agent)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"agent" => agent_params}, socket) do
    changeset =
      socket.assigns.agent
      |> Rental.change_agent(agent_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"agent" => agent_params}, socket) do
    save_agent(socket, socket.assigns.action, agent_params)
  end

  defp save_agent(socket, :edit, agent_params) do
    case Rental.update_agent(socket.assigns.agent, agent_params) do
      {:ok, _agent} ->
        {:noreply,
         socket
         |> put_flash(:info, "Agent updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_agent(socket, :new, agent_params) do
    case Rental.create_agent(agent_params) do
      {:ok, _agent} ->
        {:noreply,
         socket
         |> put_flash(:info, "Agent created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
