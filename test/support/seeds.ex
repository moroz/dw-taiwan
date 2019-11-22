defmodule Diamondway.TestSeeds do
  alias Diamondway.Repo

  def run do
    Repo.insert(
      %Diamondway.Countries.Country{
        name: "Russia"
      },
      on_conflict: :nothing
    )

    Repo.insert(
      %Diamondway.Users.User{
        id: 1,
        display_name: "System User",
        email: "system@mahamudra.taipei"
      },
      on_conflict: :nothing
    )
  end
end
