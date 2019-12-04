defmodule DiamondwayWeb.GraphQL.Types.Dashboard do
  use Absinthe.Schema.Notation

  object :dashboard_data do
    field :total_count, non_null(:integer)
    field :invited_count, non_null(:integer)
    field :canceled_count, non_null(:integer)
    field :paid_count, non_null(:integer)
    field :unverified_count, non_null(:integer)
    field :backup_count, non_null(:integer)
  end

  object :mailer_job do
    field :total_count, non_null(:integer)
    field :timestamp, non_null(:naive_datetime)
    field :completed, non_null(:boolean)
    field :states, :json
  end
end
