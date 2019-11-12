defmodule DiamondwayWeb.GraphQL.Resolvers.Dashboard do
  def get_dashboard_data(_, _) do
    Diamondway.Dashboard.get_dashboard_data()
  end
end
