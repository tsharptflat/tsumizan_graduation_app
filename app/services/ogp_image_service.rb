class OgpImageService
  def initialize(user)
    @user = user
  end

  def generate
    background = Vips::Image.new_from_file(Rails.root.join("app", "assets", "images", "ogp_background_image.png").to_s)

    total_price = UserGameLibrary.total_price(@user)
    text = Vips::Image.text(
        %(<span foreground="white" size = "50000">  あなたの積みゲー総額は</span>\n<span foreground="white" size = "200000">¥#{total_price}</span>),
        fontfile: (Rails.root.join("app", "assets", "fonts", "ZenKakuGothicNew-Black.ttf").to_s),
        font: "Zen Kaku Gothic New Black 60",
        spacing: -80,
        rgba: true
    )

    x = (background.width - text.width) / 2
    y = (background.height - text.height) / 2
    result = background.composite2(text, :over, x: x, y: y)
    result.write_to_buffer(".png")
  end
end