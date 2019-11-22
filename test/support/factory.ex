defmodule Diamondway.Factory do
  use ExMachina.Ecto, repo: Diamondway.Repo

  def email do
    sequence(:email, fn i -> "guest+#{i}@example.com" end)
  end

  def audit_factory do
    %Diamondway.Audits.Audit{
      guest: build(:guest),
      user: build(:user),
      description: "Marked as confirmed"
    }
  end

  def continent_factory do
    %Diamondway.Countries.Continent{
      name: sequence(:continent, &"Continent #{&1}")
    }
  end

  def note_factory do
    %Diamondway.Notes.Note{
      user: build(:user),
      guest: build(:guest),
      body: sequence(:note_text, &"Note text #{&1}")
    }
  end

  def user_factory do
    %Diamondway.Users.User{
      email: email(),
      display_name: "Jan Paweł II"
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
      email: email(),
      sex: :male,
      residence: build(:country),
      nationality: build(:country),
      city: "Kudowa-Zdrój"
    }
  end
end
