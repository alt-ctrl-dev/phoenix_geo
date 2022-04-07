defmodule PhoenixGeo.Rental.Agent do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:name, :description, :areas]}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "agents" do
    field :description, :string
    field :name, :string
    field :job, :string
    field :favourite, :boolean
    has_many :areas, PhoenixGeo.Schema.Area

    timestamps()
  end

  @doc false
  def changeset(agent, attrs) do
    agent
    |> cast(attrs, [:name, :description, :favourite])
    |> validate_required([:name])
  end
end
