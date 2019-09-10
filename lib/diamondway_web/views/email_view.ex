defmodule DiamondwayWeb.EmailView do
  use DiamondwayWeb, :view
  import DiamondwayWeb.GuestHelpers

  def brand_color, do: "#cd2030"

  def format_date(%module{} = date) when module in [NaiveDateTime, DateTime, Date] do
    date
    |> Timex.Timezone.convert("Asia/Taipei")
    |> Timex.format!("%d %B %Y %H:%M", :strftime)
  end

  def auto_msg_warning do
    content_tag :p,
      align: "center",
      style:
        "background-color: #fde3e4; color: #af0e14; text-align: center; padding: 12px; margin-top: 0;" do
      {:safe,
       "This message has been sent automatically.<br/>Please don&rsquo;t answer it directly."}
    end
  end

  def header(text) do
    content_tag :h1,
      align: "center",
      style: "font-family: #{font(:serif)}; font-size: 24px; font-weight: bold;" do
      {:safe, text}
    end
  end

  def font(:sans) do
    "-apple-system, BlinkMacSystemFont,'.SFNSText-Regular', 'San Francisco', 'Roboto', 'Segoe UI', 'Helvetica Neue', 'Lucida Grande', sans-serif;"
  end

  def font(:serif) do
    "Constantia, 'Lucida Bright', Lucidabright, 'Lucida Serif', Lucida, 'DejaVu Serif', 'Bitstream Vera Serif', 'Liberation Serif', Georgia, serif"
  end
end
