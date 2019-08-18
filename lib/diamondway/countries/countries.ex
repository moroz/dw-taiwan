defmodule Diamondway.Countries do
  alias Diamondway.Countries.Country
  alias Diamondway.Repo
  import Ecto.Query

  @popular [
    {"Taiwan", 70},
    {"Russia", 60},
    {"Poland", 57},
    {"Germany", 29}
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
