defmodule PhoenixGeo.Repo.Migrations.CreateAreas do
  use Ecto.Migration

  def change do
    create_if_not_exists table(:areas, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :description, :string
      add :geojson_feature, :geometry, null: false
      add :agent_id, references(:agents, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:areas, [:agent_id])
  end
end
