defmodule DiamondwayWeb.GraphQL.Resolvers.Guests do
  alias Diamondway.Guests

  def filter_guests(_, _) do
    {:ok, Guests.filter_and_paginate_guests(%{})}
  end
end
