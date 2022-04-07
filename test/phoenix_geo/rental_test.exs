defmodule PhoenixGeo.RentalTest do
  use PhoenixGeo.DataCase

  alias PhoenixGeo.Rental

  describe "agents" do
    alias PhoenixGeo.Rental.Agent

    import PhoenixGeo.RentalFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_agents/0 returns all agents" do
      agent = agent_fixture()
      assert Rental.list_agents() == [agent]
    end

    test "get_agent!/1 returns the agent with given id" do
      agent = agent_fixture()
      assert Rental.get_agent!(agent.id) == agent
    end

    test "create_agent/1 with valid data creates a agent" do
      valid_attrs = %{description: "some description", name: "some name"}

      assert {:ok, %Agent{} = agent} = Rental.create_agent(valid_attrs)
      assert agent.description == "some description"
      assert agent.name == "some name"
    end

    test "create_agent/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rental.create_agent(@invalid_attrs)
    end

    test "update_agent/2 with valid data updates the agent" do
      agent = agent_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %Agent{} = agent} = Rental.update_agent(agent, update_attrs)
      assert agent.description == "some updated description"
      assert agent.name == "some updated name"
    end

    test "update_agent/2 with invalid data returns error changeset" do
      agent = agent_fixture()
      assert {:error, %Ecto.Changeset{}} = Rental.update_agent(agent, @invalid_attrs)
      assert agent == Rental.get_agent!(agent.id)
    end

    test "delete_agent/1 deletes the agent" do
      agent = agent_fixture()
      assert {:ok, %Agent{}} = Rental.delete_agent(agent)
      assert_raise Ecto.NoResultsError, fn -> Rental.get_agent!(agent.id) end
    end

    test "change_agent/1 returns a agent changeset" do
      agent = agent_fixture()
      assert %Ecto.Changeset{} = Rental.change_agent(agent)
    end
  end
end
