defmodule Diamondway.Guests.GuestStateMachine do
  use Machinery,
    states: ~w(unverified verified invited backup canceled paid)a,
    transitions: %{
      unverified: [:verified, :invited, :backup, :canceled],
      invited: [:canceled, :paid],
      verified: [:backup, :invited, :canceled],
      backup: [:invited, :canceled],
      paid: [:canceled]
    }
end
