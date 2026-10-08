module ApplicationHelper
  # 価格が未取得(取得中・取得失敗)のゲームで「¥」だけが表示されないよう、各ページの価格表示はこれを通す
  def game_price_label(game)
    return '価格不明' if game.price.nil?

    number_to_currency(game.price, precision: 0, unit: '¥', format: '%u%n')
  end
end
