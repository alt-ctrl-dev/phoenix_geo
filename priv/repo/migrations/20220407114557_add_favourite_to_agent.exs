defmodule PhoenixGeo.Repo.Migrations.AddFavouriteToAgent do
  use Ecto.Migration

  def change do
    alter table(:agents) do
      add :favourite, :boolean
    end
  end
end
