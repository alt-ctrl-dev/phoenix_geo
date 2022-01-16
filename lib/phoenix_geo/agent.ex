defmodule PhoenixGeo.Schema.Agent do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:name, :description, :areas]}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "agents" do
    field :description, :string
    field :name, :string
    field :job, :string
    has_many :areas, PhoenixGeo.Schema.Area

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end
