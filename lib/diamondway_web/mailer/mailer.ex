defmodule DiamondwayWeb.Mailer do
  use Swoosh.Mailer, otp_app: :diamondway

  def deliver_and_catch(email) do
    try do
      deliver(email)
    catch
      error -> error
    end
  end
end
