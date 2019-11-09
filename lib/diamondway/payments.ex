defmodule Diamondway.Payments do
  alias Diamondway.Guests.Guest
  alias Diamondway.Guests
  alias Diamondway.Repo
  import Ecto.Query

  def token(bytes \\ 10) do
    :crypto.strong_rand_bytes(bytes)
    |> Base.encode16(case: :lower)
  end

  def set_payment_tokens(%Guest{} = guest) do
    Guests.update_guest(guest, %{payment_token: token(), ecpay_token: token()})
  end
end
