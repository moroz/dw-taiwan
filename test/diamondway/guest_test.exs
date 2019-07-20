defmodule Diamondway.Guests.GuestTest do
  use Diamondway.DataCase

  alias Diamondway.Guests.Guest
  alias Diamondway.Countries.Country
  alias Diamondway.Repo

  def valid_attrs(attrs \\ []) do
    russia = Repo.get_by(Country, name: "Russia")

    Enum.into(
      attrs,
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
    )
  end

  @required ~w(city email first_name last_name reference_name reference_email phone sex nationality_id residence_id)a
  @validates_confirmation ~w(single_person_registration travel_insurance visa_requirements)a

  describe "changeset/2" do
    test "is valid with valid attributes" do
      changeset = Guest.changeset(%Guest{}, valid_attrs())
      assert changeset.valid?
    end

    for attr <- @required ++ @validates_confirmation do
      test "is invalid when #{attr} is nil" do
        changeset = Guest.changeset(%Guest{}, valid_attrs([{unquote(attr), nil}]))
        refute changeset.valid?
      end
    end

    for attr <- @validates_confirmation do
      test "is invalid when #{attr} is not accepted" do
        changeset = Guest.changeset(%Guest{}, valid_attrs([{unquote(attr), false}]))
        refute changeset.valid?
      end
    end
  end
end
