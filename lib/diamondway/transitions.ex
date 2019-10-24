defmodule Diamondway.Transitions do
  alias Diamondway.Repo
  alias Diamondway.Guests
  alias Diamondway.Audits

  alias Diamondway.Guests.Guest
  alias Diamondway.Users.User

  def transition_state(%Guest{} = guest, new_state) do
    with {:ok, changeset} <- Guest.put_status(guest, new_state) do
      Repo.update!(changeset)
    end
  end

  def transition_state_with_user(%Guest{} = guest, %User{} = user, new_state) do
    Repo.transaction(fn ->
      message = message(guest.status, new_state)
      guest = transition_state(guest, new_state)
      {:ok, _audit} = Audits.create_guest_audit(guest, user, message)
      Guests.preload_countries(guest)
    end)
  end

  def message(old_state, new_state)
  def message(:unverified, :verified), do: "marked as verified"
end
