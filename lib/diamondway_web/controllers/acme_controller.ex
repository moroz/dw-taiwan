defmodule DiamondwayWeb.AcmeController do
  use DiamondwayWeb, :controller

  def challenge(conn, _) do
    send_resp(
      conn,
      200,
      "WHO13ceSmFjzo3Aq9Ez5pVUsWT5KNjEk2tq2kAw2GGQ.whFlI7tDwjfae_Cfnryl5BVeBwac4Etjx9aZIBKu2YI"
    )
  end
end
