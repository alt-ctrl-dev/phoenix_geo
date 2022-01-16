defmodule PhoenixGeo.Agents do
  @moduledoc """
  The Projects context.
  """

  import Ecto.Query, warn: false
  alias PhoenixGeo.Repo

  alias PhoenixGeo.Schema.{Agent, Area}

  defp build_base_query() do
    from Agent,
      order_by: [asc: :inserted_at, desc: :name]
  end

  def get_agents() do
    build_base_query()
    |> Repo.all()
  end

  def get_agent_with_ares!(id) do
    fields = [:id, :name, :description, :inserted_at]
    updated_fields = fields ++ [areas: fields]

    query =
      from project in build_base_query(),
        join: area in Area,
        on: project.id == area.agent_id,
        preload: [areas: area],
        select: struct(project, ^updated_fields),
        select_merge: %{
          areas: %{area: fragment("st_area(?) * 1000 * 1000", area.geojson_feature)}
        }

    Repo.get!(query, id)
  end
end
