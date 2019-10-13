defmodule Diamondway.Factory do
  use ExMachina.Ecto, repo: Diamondway.Repo

  def continent_factory do
    %Diamondway.Countries.Continent{
      name: sequence(:continent, &"Continent #{&1}")
    }
  end

  def country_factory do
    %Diamondway.Countries.Country{
      name: sequence(:country, &"Country #{&1}"),
      continent: build(:continent)
    }
  end

  def guest_factory do
    %Diamondway.Guests.Guest{
      first_name: "Jan",
      last_name: "Paweł",
      reference_email: "reference@example.com",
      reference_name: "Józef Piłsudski",
      phone: "+48555123123",
      email: sequence(:email, fn i -> "guest+#{i}@example.com" end),
      sex: :male,
      residence: build(:country),
      nationality: build(:country)
    }
  end
end
