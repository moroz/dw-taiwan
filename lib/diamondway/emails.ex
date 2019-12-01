defmodule Diamondway.Emails do
  alias Diamondway.Repo
  alias Diamondway.Audits
  alias Diamondway.Guests
  alias Diamondway.Payments
  alias Diamondway.Guests.Guest
  alias DiamondwayWeb.GuestEmail
  alias DiamondwayWeb.Mailer

  email_types = Application.get_env(:diamondway, Diamondway.Emails) |> Keyword.get(:email_types)
  @email_types email_types

  defp email_allowed?(type, guest)
  defp email_allowed?(:registration, _), do: true
  defp email_allowed?(:backup, guest), do: guest.status == :backup
  defp email_allowed?(_, guest), do: guest.status == :invited

  def send_payment_email(guest, user, token) do
    GuestEmail.payment(guest, token)
    |> deliver_and_log(guest, user, :payment)
  end

  def send_email(type, guest, user) when type in @email_types do
    case email_allowed?(type, guest) do
      true ->
        GuestEmail.render_email(type, guest)
        |> deliver_and_log(guest, user, type)

      _ ->
        {:error, :illegal_email_type}
    end
  end

  defp deliver_and_log(email, guest, user, type) do
    Repo.transaction(fn ->
      case Mailer.deliver_and_catch(email) do
        {:ok, _ref} ->
          {:ok, updated} = mark_email_sent(guest, type)
          Audits.create_guest_audit(guest, user, "sent out #{type} e-mail.")
          Guests.preload_countries(updated)

        error ->
          Audits.create_guest_audit(guest, user, "#{type} email delivery failed.")
          error
      end
    end)
  end

  defp email_sent?(guest, email_type) when email_type in @email_types do
    field = :"#{email_type}_sent"
    Map.get(guest, field)
  end

  def request_email_resend(%Guest{status: :invited} = guest, ip) do
    Repo.transaction(fn ->
      Audits.create_guest_audit(guest, 1, "requested e-mail resend.", ip)

      {:ok, guest} = Payments.issue_payment_email(guest)
      guest
    end)
  end

  def mark_email_sent(guest, email_type) do
    if email_sent?(guest, email_type) do
      {:ok, guest}
    else
      attrs = Map.new([{"#{email_type}_sent", true}])

      Guest.changeset(guest, attrs)
      |> Repo.update()
    end
  end
end
