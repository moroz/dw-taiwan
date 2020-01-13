defmodule DiamondwayWeb.GraphQL.Resolvers.Emails do
  alias Diamondway.Guests
  alias Diamondway.Emails
  alias Diamondway.Payments

  def send_email(%{id: guest_id, type: type}, %{context: %{current_user: user}}) do
    guest = Guests.get_guest!(guest_id)

    case Emails.send_email(type, guest, user) do
      {:ok, updated} ->
        {:ok, %{success: true, guest: updated}}

      {_, _, reason} ->
        {:ok, %{success: false, message: reason, guest: guest}}
    end
  end
end
