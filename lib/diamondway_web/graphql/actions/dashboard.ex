defmodule DiamondwayWeb.GraphQL.Actions.Dashboard do
  use Absinthe.Schema.Notation
  alias DiamondwayWeb.GraphQL.Resolvers

  object :dashboard_queries do
    field :dashboard_data, non_null(:dashboard_data) do
      resolve(&Resolvers.Dashboard.get_dashboard_data/2)
    end

    field :mailer_jobs, non_null(list_of(:mailer_job)) do
      resolve(&Resolvers.Dashboard.get_mailer_jobs/2)
    end
  end
end
