defmodule PhoenixGeo.Schema.Area do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:name, :description, :geojson_feature]}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "areas" do
    field :description, :string
    field :geojson_feature, Geo.PostGIS.Geometry
    field :name, :string
    field :area, :decimal, virtual: true
    belongs_to :agent, PhoenixGeo.Schema.Agent

    timestamps()
  end

  @doc false
  def changeset(area, attrs) do
    area
    |> cast(attrs, [:name, :description, :geojson_feature])
    |> validate_required([:name, :geojson_feature])
  end
end
