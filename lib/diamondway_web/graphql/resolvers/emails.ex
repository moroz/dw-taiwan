defmodule DiamondwayWeb.GraphQL.Resolvers.Emails do
  alias Diamondway.Guests
  alias Diamondway.Emails
  alias Diamondway.Payments

  def send_email(%{id: guest_id, force: force, type: type}, %{context: %{current_user: user}}) do
    guest = Guests.get_guest!(guest_id)

    case Emails.send_email(type, guest, user, force) do
      {:ok, updated} ->
        {:ok, %{success: true, guest: updated}}

      {_, _, reason} ->
        {:ok, %{success: false, message: reason, guest: guest}}
    end
  end

  def issue_payment_link(%{id: guest_id}, %{context: %{current_user: user}}) do
    guest = Guests.get_guest!(guest_id)

    case Payments.issue_payment_email(guest, user) do
      {:ok, updated} ->
        {:ok, %{success: true, guest: updated}}

      _ ->
        {:ok, %{success: false, message: "Action failed, oooops", guest: guest}}
    end
  end
end
