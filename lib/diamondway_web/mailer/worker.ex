defmodule DiamondwayWeb.Mailer.DeliveryJob do
  use Oban.Worker, queue: "mailing", max_attempts: 5, unique: [period: 300]
  alias Diamondway.Emails
  alias Diamondway.Guests

  @impl Oban.Worker
  def perform(%{"guest_id" => guest_id, "email_type" => email_type}, _job) do
    type = String.to_existing_atom(email_type)
    guest = Guests.get_guest(guest_id)
    Emails.send_email(type, guest, 1)
  end
end
