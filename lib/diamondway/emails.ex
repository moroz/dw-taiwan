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

  def enqueue(%Guest{id: guest_id}, type, timestamp \\ :os.system_time(:seconds))
      when type in @email_types do
    %{"guest_id" => guest_id, "email_type" => type, "timestamp" => timestamp}
    |> DiamondwayWeb.Mailer.DeliveryJob.new()
    |> Oban.insert()
  end

  def send_to_all(type) do
    guests = Guests.list_guests()
    batch_enqueue(guests, type)
  end

  def batch_enqueue(list, type) when is_list(list) do
    timestamp = :os.system_time(:seconds)

    for item <- list, %Guest{} = item do
      enqueue(item, type, timestamp)
    end
  end

  defp email_allowed?(type, guest)
  defp email_allowed?(:registration, guest), do: guest.status == :unreviewed
  defp email_allowed?(:backup, guest), do: guest.status == :backup
  defp email_allowed?(_, guest), do: guest.status == :invited

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
          Audits.create_guest_audit(guest, user, "sent out #{type} email.")
          guest

        error ->
          Audits.create_guest_audit(guest, user, "#{type} email delivery failed.")
          error
      end
    end)
  end

  def request_email_resend(%Guest{status: :invited} = guest, ip) do
    Repo.transaction(fn ->
      Audits.create_guest_audit(guest, 1, "requested e-mail resend.", ip)

      # {:ok, guest} = Payments.issue_payment_email(guest)
      send_email(:confirmation, guest, 1)
      guest
    end)
  end
end
