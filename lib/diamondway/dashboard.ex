defmodule Diamondway.Dashboard do
  alias Diamondway.Repo
  alias Diamondway.Enums.GuestStatus
  import Ecto.Query

  @query "select status, count(*) from guests group by rollup(status)"
  @keys ~w(paid_count invited_count backup_count canceled_count unverified_count)a

  def get_dashboard_data do
    %{rows: rows} = Repo.query!(@query)

    map = Map.new(rows, fn [key, val] -> {status_to_key(key), val} end)

    # Coalesce keys if they don't exist in the DB
    Enum.reduce(@keys, map, fn key, acc -> Map.put_new(acc, key, 0) end)
  end

  @unfinished ~w(available scheduled executing retryable)

  def get_mailer_jobs do
    from(o in "oban_jobs")
    |> select([o], {count(o), o.state, fragment("(args->>'timestamp')::integer")})
    |> group_by([o], [fragment("args->>'timestamp'"), o.state])
    |> Repo.all()
    |> Enum.reduce(%{}, fn
      {count, state, timestamp}, acc ->
        case acc[timestamp] do
          nil ->
            Map.put(acc, timestamp, %{
              timestamp: timestamp,
              states: %{state => count},
              total_count: count
            })

          %{states: states} = map ->
            states = Map.put(states, state, count)
            total = map[:total_count] + count

            Map.put(acc, timestamp, %{map | states: states, total_count: total})
        end
    end)
    |> Enum.map(fn
      {_, %{states: states} = map} ->
        completed = Enum.all?(@unfinished, fn status -> states[status] == nil end)
        Map.put(map, :completed, completed)
    end)
  end

  defp status_to_key(nil), do: :total_count

  defp status_to_key(int) when is_integer(int) do
    {:ok, key} = GuestStatus.load(int)
    :"#{key}_count"
  end
end
