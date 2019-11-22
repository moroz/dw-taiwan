defmodule Diamondway.Payments do
  alias Diamondway.Guests.Guest
  alias Diamondway.Guests
  alias Diamondway.Repo
  alias Diamondway.Emails
  import Ecto.Query

  def token(bytes \\ 10) do
    :crypto.strong_rand_bytes(bytes)
    |> Base.encode16(case: :lower)
  end

  def set_payment_token(%Guest{} = guest) do
    Guests.update_guest(guest, %{payment_token: token()})
  end

  def issue_payment_email(%Guest{status: :invited} = guest) do
    Repo.transaction(fn ->
      {:ok, updated} = set_payment_token(guest)
      Emails.send_email(:payment, updated, 1, false)
      updated
    end)
  end
end
