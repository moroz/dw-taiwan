defmodule Diamondway.Countries do
  alias Diamondway.Countries.Country
  alias Diamondway.Repo
  import Ecto.Query

  @popular [
    {"Australia", 3},
    {"Germany", 29},
    {"Czech Republic", 21},
    {"Russia", 60},
    {"Taiwan", 70},
    {"Poland", 57},
    {"New Zealand", 51}
  ]

  @separator [{"------------", nil}]

  def list_countries_for_select do
    countries =
      from(c in Country, select: {c.name, c.id})
      |> order_by([c], c.name)
      |> Repo.all()

    @popular ++ @separator ++ countries
  end
end
