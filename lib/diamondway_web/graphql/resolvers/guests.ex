defmodule DiamondwayWeb.GraphQL.Resolvers.Guests do
  alias Diamondway.Guests

  def filter_guests(params, _) do
    page = Guests.filter_and_paginate_guests(Map.get(params, :params))
    {:ok, format_page(page)}
  end

  def get_guest(%{id: id}, _) do
    {:ok, Guests.get_guest(id)}
  end

  def transition_state(%{id: guest_id, to_state: to_state}, _) do
    guest = Guests.get_guest!(guest_id)
    {:ok, Guests.transition_state(guest, to_state)}
  end

  defp format_page(page) do
    %{
      entries: page.entries,
      cursor: %{
        page: page.page_number,
        total_pages: page.total_pages,
        total_entries: page.total_entries,
        page_size: page.page_size
      }
    }
  end
end
