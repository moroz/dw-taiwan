defmodule DiamondwayWeb.EmailView do
  use DiamondwayWeb, :view
  import DiamondwayWeb.GuestHelpers

  def font(:sans) do
    "-apple-system, BlinkMacSystemFont,'.SFNSText-Regular', 'San Francisco', 'Roboto', 'Segoe UI', 'Helvetica Neue', 'Lucida Grande', sans-serif;"
  end

  def font(:serif) do
    "Constantia, 'Lucida Bright', Lucidabright, 'Lucida Serif', Lucida, 'DejaVu Serif', 'Bitstream Vera Serif', 'Liberation Serif', Georgia, serif"
  end
end
