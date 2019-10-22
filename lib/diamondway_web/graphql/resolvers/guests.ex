defmodule DiamondwayWeb.GraphQL.Resolvers.Guests do
  alias Diamondway.Guests
  alias Diamondway.Transitions

  def filter_guests(params, _) do
    page = Guests.filter_and_paginate_guests(Map.get(params, :params))
    {:ok, format_page(page)}
  end

  def get_guest(%{id: id}, _) do
    {:ok, Guests.get_guest(id)}
  end

  def transition_state(%{id: guest_id, to_state: to_state}, %{context: %{current_user: user}}) do
    guest = Guests.get_guest!(guest_id)

    res =
      case Transitions.transition_state_with_user(guest, user, to_state) do
        {:ok, guest} ->
          %{success: true, guest: guest}

        {:error, reason} ->
          %{success: false, guest: guest, message: reason}
      end

    {:ok, res}
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
