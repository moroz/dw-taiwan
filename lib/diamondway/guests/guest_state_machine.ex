defmodule Diamondway.Guests.GuestStateMachine do
  use Machinery,
    states: ~w(unverified verified invited backup canceled paid)a,
    transitions: %{
      unverified: [:verified, :invited, :backup],
      invited: [:canceled, :paid],
      verified: [:backup, :invited]
    }
end
