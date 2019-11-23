defmodule Diamondway.Guests.GuestTest do
  use Diamondway.DataCase

  alias Diamondway.Guests
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
        reference_email: "another_user@example.com",
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

  def changeset(attrs \\ []) do
    Guest.registration_changeset(%Guest{}, valid_attrs(attrs))
  end

  @required ~w(city email first_name last_name reference_name reference_email phone sex nationality_id residence_id)a
  @validates_confirmation ~w(single_person_registration travel_insurance visa_requirements)a

  describe "registration_changeset/2" do
    test "is valid with valid attributes" do
      changeset = changeset()
      assert changeset.valid?
    end

    for attr <- @required ++ @validates_confirmation do
      test "is invalid when #{attr} is nil" do
        changeset = changeset([{unquote(attr), nil}])
        refute changeset.valid?
      end
    end

    for attr <- @validates_confirmation do
      test "is invalid when #{attr} is not accepted" do
        changeset = changeset([{unquote(attr), false}])
        refute changeset.valid?
      end
    end
  end

  describe "email validation" do
    test "is valid with valid email" do
      changeset = changeset(email: "user@example.com")
      assert changeset.valid?
    end

    test "is invalid when email is an empty string" do
      changeset = changeset(email: "")
      refute changeset.valid?
    end

    test "is invalid when email is not a valid e-mail address" do
      changeset = changeset(email: "user@example")
      refute changeset.valid?
    end

    test "is invalid when email has invalid TLD" do
      changeset = changeset(email: "user@example.fake")
      refute changeset.valid?
    end
  end

  describe "get_guest_by_payment_token/1" do
    test "returns guest record when token exists" do
      guest = insert(:guest)
      payment_token = insert(:payment_token, guest: guest)
      actual = Guests.get_guest_by_payment_token(payment_token.token)
      assert actual.id == guest.id
    end

    test "returns nil when there is no such token" do
      refute Guests.get_guest_by_payment_token("foobar2000")
    end
  end
end
