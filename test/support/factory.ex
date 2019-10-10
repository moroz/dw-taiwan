defmodule Diamondway.Factory do
  use ExMachina.Ecto, repo: Diamondway.Repo

  def guest_factory do
    %Diamondway.Guests.Guest{
      first_name: "Jan",
      last_name: "Paweł",
      reference_email: "reference@example.com",
      reference_name: "Józef Piłsudski",
      phone: "+48555123123",
      email: sequence(:email, fn i -> "guest+#{i}@example.com" end),
      sex: :male
    }
  end
end
