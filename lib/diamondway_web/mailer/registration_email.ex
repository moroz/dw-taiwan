defmodule DiamondwayWeb.RegistrationEmail do
  use Phoenix.Swoosh, view: DiamondwayWeb.EmailView, layout: {DiamondwayWeb.EmailView, :layout}
  alias DiamondwayWeb.Mailer
end
