defmodule PhoenixGeo.RentalFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixGeo.Rental` context.
  """

  @doc """
  Generate a agent.
  """
  def agent_fixture(attrs \\ %{}) do
    {:ok, agent} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> PhoenixGeo.Rental.create_agent()

    agent
  end
end
