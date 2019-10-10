defmodule DiamondwayWeb.GraphQL.Resolvers.Guests do
  alias Diamondway.Guests

  def filter_guests(_, _) do
    page = Guests.filter_and_paginate_guests(%{})
    {:ok, format_page(page)}
  end

  defp format_page(page) do
    %{
      entries: page.entries,
      cursor: %{
        page: page.page_number,
        total_pages: page.total_pages,
        total_entries: page.total_entries
      }
    }
  end
end
