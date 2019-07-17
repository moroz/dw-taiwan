defmodule Diamondway.Countries do
  alias Diamondway.Countries.Country
  alias Diamondway.Repo
  import Ecto.Query

  def list_countries_for_select do
    from(c in Country, select: {c.name, c.id})
    |> order_by([c], c.name)
    |> Repo.all()
  end
end
