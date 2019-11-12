defmodule Diamondway.Guests.Guest do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  import EmailTldValidator.Ecto
  alias Diamondway.Guests.GuestStateMachine, as: StateMachine

  @required ~w(city email first_name last_name reference_name reference_email phone sex nationality_id residence_id)a
  @all @required ++
         ~w(single_person_registration travel_insurance visa_requirements notes registration_sent confirmation_sent payment_sent backup_sent payment_token paid_at)a

  schema "guests" do
    field :city, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :reference_email, :string
    field :reference_name, :string
    field :phone, :string
    field :registration_sent, :boolean
    field :confirmation_sent, :boolean
    field :backup_sent, :boolean
    field :payment_sent, :boolean

    field :sex, Diamondway.Enums.GuestSex
    field :status, Diamondway.Enums.GuestStatus, default: :unverified
    field :payment_token, :string
    field :paid_at, :utc_datetime

    belongs_to :nationality, Diamondway.Countries.Country
    belongs_to :residence, Diamondway.Countries.Country
    has_one :continent, through: [:residence, :continent]
    has_many :audits, Diamondway.Audits.Audit
    has_many :admin_notes, Diamondway.Notes.Note

    field :single_person_registration, :boolean, virtual: true
    field :travel_insurance, :boolean, virtual: true
    field :visa_requirements, :boolean, virtual: true
    field :notes, :string

    timestamps()
  end

  @doc false
  def changeset(guest, attrs) do
    guest
    |> cast(attrs, @all)
    |> validate_required(@required, message: "This field is required.")
    |> unique_constraint(:email, message: "this address has already been used")
    |> unique_constraint(:payment_token)
    |> unique_constraint(:ecpay_token)
    |> validate_email()
    |> validate_email(:reference_email)
    |> validate_different_emails()
  end

  def put_status(guest, new_state) do
    with {:ok, _} <- Machinery.transition_to(guest, StateMachine, new_state) do
      changeset =
        change(guest)
        |> put_change(:status, new_state)

      {:ok, changeset}
    end
  end

  def from_asia(query \\ __MODULE__) do
    from(g in query, join: r in assoc(g, :residence))
    |> where([g, r], r.continent_id in [1, 4])
  end

  def registration_changeset(guest, attrs) do
    changeset(guest, attrs)
    |> validate_acceptance(:single_person_registration, message: "Please confirm.")
    |> validate_acceptance(:travel_insurance,
      message: "Please confirm."
    )
    |> validate_acceptance(:visa_requirements,
      message: "Please confirm."
    )
  end

  defp validate_different_emails(changeset) do
    email = get_field(changeset, :email)
    reference_email = get_field(changeset, :reference_email)

    if email not in ["", nil] and reference_email not in ["", nil] and
         String.downcase(email) == String.downcase(reference_email) do
      add_error(changeset, :reference_email, "This address should be different from yours.")
    else
      changeset
    end
  end
end
