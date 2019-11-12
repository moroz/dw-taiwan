defmodule Diamondway.Guests.GuestStateMachine do
  use Machinery,
    states: ~w(unverified invited backup canceled paid)a,
    transitions: %{
      "*" => [:unverified, :canceled],
      unverified: [:invited, :backup, :canceled],
      invited: [:canceled, :paid, :backup, :unverified],
      backup: [:invited, :canceled, :unverified],
      paid: [:canceled]
    }
end
