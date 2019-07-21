defmodule DiamondwayWeb.LogoHelper do
  alias DiamondwayWeb.Router.Helpers, as: Routes
  import Phoenix.HTML.Tag

  def logo_path(size \\ :desktop, light \\ false) do
    Routes.static_path(DiamondwayWeb.Endpoint, "/images/logo-#{size}#{suffix(light)}.svg")
  end

  defp suffix(true), do: "-light"
  defp suffix(_), do: ""

  def logo_tag(size, light) do
    img_tag(logo_path(size, light), alt: "Mahamudra Taipei")
  end
end
