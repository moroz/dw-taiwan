defmodule Diamondway.PaymentsTest do
  use Diamondway.DataCase
  alias Diamondway.Payments
  alias Diamondway.Guests.Guest
  alias ECPay.Checksum
  import Mock

  describe "verify_payment/1" do
    test "returns {:ok, guest} when payment is successful" do
      with_mock Checksum, verify: fn _ -> :ok end do
        guest = insert(:guest)
        {:ok, token} = Payments.create_token_for_guest(guest)
        data = %{"MerchantTradeNo" => token, "RtnCode" => "1"}
        assert {:ok, %Guest{}} = Payments.verify_payment(data)
      end
    end

    test "returns {:error, :payment_field} when payment is unsuccessful" do
      with_mock Checksum, verify: fn _ -> :ok end do
        guest = insert(:guest)
        {:ok, token} = Payments.create_token_for_guest(guest)
        data = %{"MerchantTradeNo" => token, "RtnCode" => "0"}
        assert {:error, :payment_failed} = Payments.verify_payment(data)
      end
    end

    test "returns {:error, :not_found} when payment is unsuccessful" do
      with_mock Checksum, verify: fn _ -> :ok end do
        data = %{"MerchantTradeNo" => "foobar2000", "RtnCode" => "1"}
        assert {:error, :not_found} = Payments.verify_payment(data)
      end
    end
  end
end
