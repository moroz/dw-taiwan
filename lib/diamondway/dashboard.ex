defmodule Diamondway.Dashboard do
  alias Diamondway.Repo
  alias Diamondway.Enums.GuestStatus

  @query "select status, count(*) from guests group by rollup(status)"
  @keys ~w(paid_count invited_count backup_count canceled_count)a

  def get_dashboard_data do
    %{rows: rows} = Repo.query!(@query)

    map = Map.new(rows, fn [key, val] -> {status_to_key(key), val} end)

    # Coalesce keys if they don't exist in the DB
    Enum.reduce(@keys, map, fn key, acc -> Map.put_new(acc, key, 0) end)
  end

  defp status_to_key(nil), do: :total_count

  defp status_to_key(int) when is_integer(int) do
    {:ok, key} = GuestStatus.load(int)
    :"#{key}_count"
  end
end
