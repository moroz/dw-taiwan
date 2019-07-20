defmodule Diamondway.TestSeeds do
  alias Diamondway.Repo

  def run do
    Repo.insert(
      %Diamondway.Countries.Country{
        name: "Russia"
      },
      on_conflict: :nothing
    )
  end
end
