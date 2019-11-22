defmodule Diamondway.PaymentsTest do
  use Diamondway.DataCase
  alias Diamondway.Payments
  alias DiamondwayWeb.GuestEmail
  import Swoosh.TestAssertions

  describe "issue_payment_email/1" do
    test "sets the guest's payment_token and sends email" do
      guest = insert(:guest, status: :invited)
      refute guest.payment_token
      {:ok, updated} = Payments.issue_payment_email(guest)
      assert is_binary(updated.payment_token)
      assert_email_sent(GuestEmail.payment(updated))
    end
  end
end
