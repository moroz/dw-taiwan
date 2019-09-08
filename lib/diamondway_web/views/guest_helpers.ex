defmodule DiamondwayWeb.GuestHelpers do
  use Phoenix.HTML

  alias Diamondway.Guests.Guest, warn: false

  def full_name(%{first_name: first, last_name: last}) do
    "#{first} #{last}"
  end
end