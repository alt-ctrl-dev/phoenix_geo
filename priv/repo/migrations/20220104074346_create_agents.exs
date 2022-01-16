defmodule PhoenixGeo.Repo.Migrations.CreateAgents do
  use Ecto.Migration

  def change do
    create_if_not_exists table(:agents, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :description, :string
      add :job, :string

      timestamps()
    end
  end
end
