defmodule Diamondway.Guests.GuestTest do
  use Diamondway.DataCase

  alias Diamondway.Guests.Guest
  alias Diamondway.Countries.Country
  alias Diamondway.Repo

  def valid_attrs() do
    russia = Repo.get_by(Country, name: "Russia")

    %{
      city: "Moscow",
      email: "user@example.com",
      first_name: "Sergey",
      last_name: "Solzhenicyn",
      reference_name: "Dasha",
      reference_email: "user@example.com",
      phone: "+886912345678",
      sex: :male,
      nationality_id: russia.id,
      residence_id: russia.id,
      single_person_registration: true,
      travel_insurance: true,
      visa_requirements: true
    }
  end

  describe "changeset/2" do
    test "is valid with valid attributes" do
      changeset = Guest.changeset(%Guest{}, valid_attrs())
      assert changeset.valid?
    end
  end
end
