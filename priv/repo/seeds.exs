# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhoenixGeo.Repo.insert!(%PhoenixGeo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

#
alias PhoenixGeo.Repo
alias PhoenixGeo.Schema.{Agent, Area}

for _i <- 1..10 do
  agent =
    %Agent{
      name: "#{Faker.Person.first_name()} #{Faker.Person.last_name()}",
      description: nil,
      job: Faker.Commerce.department()
    }
    |> Repo.insert!()

  for _i <- 1..Faker.Random.Elixir.random_between(1, 10) do
    lat = Faker.Address.latitude()
    lon = Faker.Address.longitude()
    subtractor = Faker.Random.Elixir.random_uniform()
    # lat2 = Faker.Address.latitude()
    geojson =
      "{ \"type\": \"Polygon\", \"coordinates\": [[ [#{lon}, #{lat}], [#{lon - subtractor}, #{lat}], [#{lon - subtractor}, #{lat - subtractor}], [#{lon}, #{lat}] ]]}"

    attrs = %{
      name: Faker.Company.En.name(),
      geojson_feature: geojson
    }

    Ecto.build_assoc(agent, :areas) |> Area.changeset(attrs) |> Repo.insert!()
  end
end
