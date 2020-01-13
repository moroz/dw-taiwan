defmodule Diamondway.Payments do
  alias Diamondway.Guests.Guest
  alias Diamondway.Guests
  alias Diamondway.Repo
  alias Diamondway.Emails
  import DiamondwayWeb.GuestHelpers
  import Ecto.Query
  alias ECPay.{AIOParams, Checksum}

  alias Diamondway.Payments.PaymentToken

  defp price, do: Application.get_env(:diamondway, :course_price, 4800)

  def payment_description(guest) do
    "Taipei Mahamudra Ticket for #{full_name(guest)}"
  end

  def create_token_for_guest(%Guest{} = guest) do
    {:ok, record} = create_payment_token(%{guest_id: guest.id})
    {:ok, record.token}
  end

  def list_guest_tokens(%Guest{id: guest_id}) do
    PaymentToken
    |> where([p], p.guest_id == ^guest_id)
    |> Repo.all()
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

  @spec payment_params_for_guest(Diamondway.Guests.Guest.t(), binary()) :: map()
  def payment_params_for_guest(%Guest{} = guest, token) do
    %AIOParams{
      transaction_no: token,
      description: "Taipei Mahamudra",
      amount: price(),
      timestamp: Timex.now(),
      item_name: payment_description(guest),
      payment: "Credit",
      language: "ENG"
    }
    |> AIOParams.to_form_data()
  end

  def get_payment_token!(id), do: Repo.get!(PaymentToken, id)

  def create_payment_token(attrs \\ %{}) do
    %PaymentToken{}
    |> PaymentToken.changeset(attrs)
    |> Repo.insert()
  end

  def delete_payment_token(%PaymentToken{} = payment_token) do
    Repo.delete(payment_token)
  end
end
