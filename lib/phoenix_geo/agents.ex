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

  def get_agent_with_areas!(id) do
    area_q =
      from(a in Area,
        # select: struct(a, ^fields),
        select_merge: %{
          area: fragment("st_area(?) * 1000 * 1000", a.geometry)
        }
      )

    Repo.get!(
      from(p in build_base_query(),
        # select: struct(project, ^updated_fields),
        preload: [areas: ^area_q]
      ),
      id
    )
  end
end
