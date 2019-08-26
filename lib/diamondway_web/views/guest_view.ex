defmodule DiamondwayWeb.GuestView do
  use DiamondwayWeb, :view
  alias Diamondway.Countries.Country

  def full_name(%{first_name: first_name, last_name: last_name}), do: "#{first_name} #{last_name}"

  def display_country(%{
        residence_id: country_id,
        nationality_id: country_id,
        residence: %Country{name: name}
      }) do
    name
  end

  def display_country(%{
        residence: %Country{name: residence},
        nationality: %Country{name: nationality}
      }) do
    "#{residence} (#{nationality})"
  end

  def reference(%{reference_name: name, reference_email: email}) do
    {:safe, "#{name}, <span class=\"email is-monospace\">&lt;#{email}&gt;</span>"}
  end
end
