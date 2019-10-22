defmodule Diamondway.Guests.CSVGenerator do
  alias NimbleCSV.RFC4180, as: CSV
  alias Diamondway.Repo
  alias Diamondway.Guests.Guest

  @columns [
    "ID",
    "First name",
    "Last Name",
    "SEX",
    "Status",
    "Nationality",
    "Living in",
    "E-mail",
    "Reference",
    "Notes"
  ]
  @bom "\xEF\xBB\xBF"

  import Ecto.Query

  def readable_file_name do
    Timex.now("Asia/Taipei")
    |> Timex.format!("{YYYY}{M}{D}{h24}{m}.csv")
  end

  def base_query do
    from(g in Guest)
    |> join(:inner, [g], r in assoc(g, :residence))
    |> join(:inner, [g], n in assoc(g, :nationality))
    |> select(
      [g, r, n],
      [
        g.id,
        g.first_name,
        g.last_name,
        g.sex,
        g.status,
        n.name,
        fragment("? || ', ' || ?", g.city, r.name),
        fragment("lower(?)", g.email),
        fragment("? || ' <' || lower(?) || '>'", g.reference_name, g.reference_email),
        g.notes
      ]
    )
    |> order_by([g], :id)
  end

  def get_guests_csv do
    rows =
      base_query
      |> Repo.all()

    iodata = CSV.dump_to_iodata([@columns | rows])
    [@bom | iodata]
  end
end
