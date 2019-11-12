defmodule Diamondway.Dashboard do
  alias Diamondway.Repo
  import Ecto.Query
  alias Diamondway.Enums.GuestStatus

  @query "select status, count(*) from guests group by rollup(status)"

  def get_dashboard_data do
    %{rows: rows} = Repo.query!(@query)
    Map.new(rows, fn [key, val] -> {status_to_key(key), val} end)
  end

  defp status_to_key(nil), do: :total_count

  defp status_to_key(int) when is_integer(int) do
    {:ok, key} = GuestStatus.load(int)
    :"#{key}_count"
  end
end
