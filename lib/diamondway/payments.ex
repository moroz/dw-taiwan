defmodule Diamondway.Payments do
  alias Diamondway.Guests.Guest
  alias Diamondway.Guests
  alias Diamondway.Repo
  alias Diamondway.Emails
  import Ecto.Query
  import DiamondwayWeb.GuestHelpers
  alias ECPay.{AIOParams, Checksum}

  defp price, do: Application.get_env(:diamondway, :course_price, 4800)

  def token(bytes \\ 10) do
    :crypto.strong_rand_bytes(bytes)
    |> Base.encode16(case: :lower)
  end

  def issue_payment_email(%Guest{status: :invited} = guest) do
    Repo.transaction(fn ->
      {:ok, updated} = set_payment_token(guest)
      Emails.send_email(:payment, updated, 1, false)
      updated
    end)
  end

  def payment_description(guest) do
    "Taipei Mahamudra Ticket for #{full_name(guest)}"
  end

  def set_payment_token(%Guest{} = guest) do
    Guests.update_guest(guest, %{payment_token: token()})
  end

  def verify_payment(data) when is_map(data) do
    with :ok <- Checksum.verify(data) do
      %{
        "MerchantTradeNo" => token,
        "RtnCode" => return_code
      } = data

      if return_code in [1, "1"] do
        case Guests.get_guest_by_payment_token(token) do
          %Guest{} = guest ->
            {:ok, guest}

          _ ->
            {:error, :not_found}
        end
      else
        {:error, :payment_failed}
      end
    end
  end

  def payment_params_for_guest(%Guest{} = guest) do
    %AIOParams{
      transaction_no: guest.payment_token,
      description: "Taipei Mahamudra",
      amount: price(),
      timestamp: Timex.now(),
      item_name: payment_description(guest),
      payment: "Credit",
      language: "ENG"
    }
    |> AIOParams.to_form_data()
  end
end
