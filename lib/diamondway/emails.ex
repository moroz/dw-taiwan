defmodule Diamondway.Emails do
  alias Diamondway.Repo
  alias Diamondway.Audits
  alias Diamondway.Guests
  alias Diamondway.Guests.Guest
  alias DiamondwayWeb.RegistrationEmail
  alias DiamondwayWeb.Mailer

  email_types = Application.get_env(:diamondway, Diamondway.Emails) |> Keyword.get(:email_types)
  @email_types email_types

  defp email_allowed?(type, guest)
  defp email_allowed?(:registration, _), do: true
  defp email_allowed?(:backup, guest), do: guest.status == :backup
  defp email_allowed?(_, guest), do: guest.status == :invited

  def send_email(type, guest, user, force) when type in @email_types do
    if !email_sent?(guest, type) || force do
      case email_allowed?(type, guest) do
        true ->
          do_send_email(type, guest, user)

        _ ->
          {:error, :illegal_email_type}
      end
    else
      {:error, :already_sent}
    end
  end

  defp do_send_email(type, guest, user) do
    Repo.transaction(fn ->
      email = RegistrationEmail.render_email(type, guest)
      resending = email_sent?(guest, type)

      case Mailer.deliver_and_catch(email) do
        {:ok, _ref} ->
          {:ok, updated} = mark_email_sent(guest, type)
          Audits.create_guest_audit(guest, user, success_audit_text(type, resending))
          Guests.preload_countries(updated)

        error ->
          Audits.create_guest_audit(guest, user, "#{type} email delivery failed.")
          error
      end
    end)
  end

  defp success_audit_text(type, resending) do
    case resending do
      false ->
        "sent out #{type} e-mail."

      _ ->
        "resent #{type} e-mail."
    end
  end

  defp email_sent?(guest, email_type) when email_type in @email_types do
    field = :"#{email_type}_sent"
    Map.get(guest, field)
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
