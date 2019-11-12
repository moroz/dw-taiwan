defmodule DiamondwayWeb.RegistrationView do
  use DiamondwayWeb, :view

  def guest_email(%{email: email}) do
    content_tag :span, class: "monospace" do
      email
    end
  end
end
