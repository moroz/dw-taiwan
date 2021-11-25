defmodule DiamondwayWeb.EmailView do
  use DiamondwayWeb, :view
  import DiamondwayWeb.GuestHelpers

  def brand_color, do: "#cd2030"
  def body_bg, do: "#F8F8F8"

  def letter_date do
    Timex.now("Asia/Taipei")
    |> Timex.format!("Taipei, {D} {Mfull} {YYYY}")
  end

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
      {:safe, "Note: This message has been sent automatically."}
    end
  end

  @letter_attrs [style: "font-family: 'Georgia'; text-indent: 1.5em"]
  def letter(do: paragraph) do
    content_tag(:p, @letter_attrs, do: paragraph)
  end

  def letter(attrs, do: paragraph) when is_list(attrs) do
    merged = Keyword.merge(@letter_attrs, attrs)
    content_tag(:p, merged, do: paragraph)
  end

  def disclaimer do
    content_tag :p, align: "center", style: "font-size: .85em; margin-top: 2.5em; color: #555" do
      {:safe,
       "You are receiving this email because you have registered for the 2020 Mahamudra Course with Lama Ole Nydahl in Taipei, Taiwan. If you would like to be removed from the database, please <a href=\"mailto:info@mahamudra.taipei\">let us know</a>."}
    end
  end

  def header(text) do
    content_tag :h1,
      align: "center",
      style: "font-family: #{font(:sans)}; font-size: 24px; font-weight: bold;" do
      {:safe, text}
    end
  end

  def font(:sans) do
    "'Segoe UI', -apple-system, BlinkMacSystemFont,'.SFNSText-Regular', 'Roboto', 'Helvetica Neue', 'Lucida Grande', Verdana, sans-serif;"
  end

  def font(:serif) do
    "Constantia, 'Lucida Bright', Lucidabright, 'Lucida Serif', Lucida, 'DejaVu Serif', 'Bitstream Vera Serif', 'Liberation Serif', Georgia, serif"
  end
end
