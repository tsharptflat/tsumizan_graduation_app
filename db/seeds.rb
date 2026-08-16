# character_type
character_type = CharacterType.find_or_create_by!(name: 'いらすと子') do |ct|
  ct.image_path = 'https://res.cloudinary.com/dvswzgioa/image/upload/q_auto/f_auto/v1777086275/business_woman1_1_smile_ujoauq.png'
end

# 状況ごとのconditions
## 総額
condition_show_min = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'users_show', min_price: 0, max_price: 0)
condition_show_min.update!(friendship_level: 1)

condition_show_low = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'users_show', min_price: 1, max_price: 5000)
condition_show_low.update!(friendship_level: 1)

condition_show_med = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'users_show', min_price: 5001, max_price: 10000)
condition_show_med.update!(friendship_level: 1)

condition_show_high = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'users_show', min_price: 10001, max_price: 30000)
condition_show_high.update!(friendship_level: 1)

condition_show_max = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'users_show', min_price: 30001, max_price: nil)
condition_show_max.update!(friendship_level: 1)

## 価格取得中(読み込み中)用
condition_show_loading = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'users_show_loading', min_price: 0, max_price: 999999999)
condition_show_loading.update!(friendship_level: 1)

## キャラ詳細ページ用(汎用、積みゲー0の時は専用セリフのみにするためmin_price:1から。レベルが上がるごとにセリフのバリエーションが増える)
condition_communicate_show = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_show', min_price: 1, max_price: 999999999, friendship_level: 1)
condition_communicate_show.save!

condition_communicate_show_lv2 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_show', min_price: 1, max_price: 999999999, friendship_level: 2)
condition_communicate_show_lv2.save!

condition_communicate_show_lv3 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_show', min_price: 1, max_price: 999999999, friendship_level: 3)
condition_communicate_show_lv3.save!

condition_communicate_show_lv4 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_show', min_price: 1, max_price: 999999999, friendship_level: 4)
condition_communicate_show_lv4.save!

condition_communicate_show_lv5 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_show', min_price: 1, max_price: 999999999, friendship_level: 5)
condition_communicate_show_lv5.save!

## キャラ詳細ページ用(金額帯別)
condition_communicate_zero = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_show', min_price: 0, max_price: 0)
condition_communicate_zero.update!(friendship_level: 1)

condition_communicate_tier1 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_show', min_price: 1, max_price: 3000)
condition_communicate_tier1.update!(friendship_level: 1)

condition_communicate_tier2 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_show', min_price: 3001, max_price: 5000)
condition_communicate_tier2.update!(friendship_level: 1)

condition_communicate_tier3 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_show', min_price: 5001, max_price: 10000)
condition_communicate_tier3.update!(friendship_level: 1)

condition_communicate_tier4 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_show', min_price: 10001, max_price: 20000)
condition_communicate_tier4.update!(friendship_level: 1)

condition_communicate_tier5 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_show', min_price: 20001, max_price: 30000)
condition_communicate_tier5.update!(friendship_level: 1)

condition_communicate_tier6 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_show', min_price: 30001, max_price: 40000)
condition_communicate_tier6.update!(friendship_level: 1)

condition_communicate_tier7 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_show', min_price: 40001, max_price: 50000)
condition_communicate_tier7.update!(friendship_level: 1)

condition_communicate_tier8 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_show', min_price: 50001, max_price: 75000)
condition_communicate_tier8.update!(friendship_level: 1)

condition_communicate_tier9 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_show', min_price: 75001, max_price: 100000)
condition_communicate_tier9.update!(friendship_level: 1)

condition_communicate_tier10 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_show', min_price: 100001, max_price: nil)
condition_communicate_tier10.update!(friendship_level: 1)

## ギフトページ用(レベルが上がるごとにセリフのバリエーションが増える)
condition_gift_show = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_gift_show', min_price: 0, max_price: 999999999, friendship_level: 1)
condition_gift_show.save!

condition_gift_show_lv2 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_gift_show', min_price: 0, max_price: 999999999, friendship_level: 2)
condition_gift_show_lv2.save!

condition_gift_show_lv3 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_gift_show', min_price: 0, max_price: 999999999, friendship_level: 3)
condition_gift_show_lv3.save!

condition_gift_show_lv4 = CharacterTextCondition.find_or_initialize_by(character_type_id: character_type.id, page: 'user_characters_gift_show', min_price: 0, max_price: 999999999, friendship_level: 4)
condition_gift_show_lv4.save!

# 表情差分
expression_neutral = CharacterExpression.find_or_create_by!(character_type_id: character_type.id, emotion_type: 'neutral') do |ce|
  ce.image_path = 'https://res.cloudinary.com/dvswzgioa/image/upload/q_auto/f_auto/v1777086275/business_woman1_1_smile_ujoauq.png'
end

expression_happy = CharacterExpression.find_or_create_by!(character_type_id: character_type.id, emotion_type: 'happy') do |ce|
  ce.image_path = 'https://res.cloudinary.com/dvswzgioa/image/upload/q_auto/f_auto/v1777086275/business_woman1_4_laugh_nkgkla.png'
end

expression_surprised = CharacterExpression.find_or_create_by!(character_type_id: character_type.id, emotion_type: 'surprised') do |ce|
  ce.image_path = 'https://res.cloudinary.com/dvswzgioa/image/upload/q_auto/f_auto/v1777086276/business_woman2_3_surprise_ss4wsg.png'
end

expression_disappointed = CharacterExpression.find_or_create_by!(character_type_id: character_type.id, emotion_type: 'disappointed') do |ce|
  ce.image_path = 'https://res.cloudinary.com/dvswzgioa/image/upload/q_auto/f_auto/v1777086276/business_woman2_4_think_cqlpap.png'
end

expression_shock = CharacterExpression.find_or_create_by!(character_type_id: character_type.id, emotion_type: 'shock') do |ce|
  ce.image_path = 'https://res.cloudinary.com/dvswzgioa/image/upload/q_auto/f_auto/v1777086275/business_woman2_2_shock_nmiaai.png'
end

# テキスト
ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_show_min.id, character_expression_id: expression_happy.id) do |ct|
  ct.text = '積みゲーなし！素晴らしいですね！'
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_show_low.id, character_expression_id: expression_neutral.id) do |ct|
  ct.text = 'いい消化状況ですね！増やさないように注意していきましょう！'
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_show_med.id, character_expression_id: expression_neutral.id) do |ct|
  ct.text = '少し積んでいるゲームもあるようですね、次にどれをプレイしていきますか？'
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_show_high.id, character_expression_id: expression_disappointed.id) do |ct|
  ct.text = '少し積みゲーが多いようですね…ここからプレイしていきましょう！'
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_show_max.id, character_expression_id: expression_shock.id) do |ct|
  ct.text = 'なかなかの積み具合ですね…'
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_show_loading.id, character_expression_id: expression_happy.id) do |ct|
  ct.text = '少しドキドキしますね…！'
end

# キャラ詳細ページ(汎用、Lv1)
ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_show.id, text: '今日はどの積みゲーをプレイしていきますか？') do |ct|
  ct.character_expression_id = expression_happy.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_show.id, text: '他の人と比べてみることで初めて見えることもあったりしますよね。') do |ct|
  ct.character_expression_id = expression_neutral.id
end

# キャラ詳細ページ(汎用、Lv2)
ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_show_lv2.id, text: '今日も積みゲーに向き合っていて素晴らしいですね！') do |ct|
  ct.character_expression_id = expression_happy.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_show_lv2.id, text: '思い切ってはじめからリスタートしてみるとするするっと進められちゃうこともありますよ！') do |ct|
  ct.character_expression_id = expression_happy.id
end

# キャラ詳細ページ(汎用、Lv3)
ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_show_lv3.id, text: '疲れているときは無理せずに休んでくださいね…？') do |ct|
  ct.character_expression_id = expression_neutral.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_show_lv3.id, text: '積みゲー推移グラフを見てみると、モチベーションに繋がるかもしれませんよ！') do |ct|
  ct.character_expression_id = expression_happy.id
end

# キャラ詳細ページ(汎用、Lv4)
ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_show_lv4.id, text: '積みゲーの中にあなたのための1本が眠っているかも！') do |ct|
  ct.character_expression_id = expression_happy.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_show_lv4.id, text: '積みゲーが少なくなっていくと、新作ゲームもきっとより楽しめますよっ！') do |ct|
  ct.character_expression_id = expression_happy.id
end

# キャラ詳細ページ(汎用、LvMAX)
ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_show_lv5.id, text: 'たまにはセールも覗いてみちゃうのはどうですか？') do |ct|
  ct.character_expression_id = expression_happy.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_show_lv5.id, text: '楽しんでプレイするのが一番、ですねっ！') do |ct|
  ct.character_expression_id = expression_happy.id
end

# キャラ詳細ページ(金額帯別)
ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_zero.id, text: '積みゲー0なんてすばらしいですよ！よく頑張りましたね！') do |ct|
  ct.character_expression_id = expression_happy.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_tier1.id, text: '残りの積みゲーも少なくなってきましたね、あと少しですよっ！') do |ct|
  ct.character_expression_id = expression_happy.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_tier2.id, text: 'いい調子ですね、このまま積みゲー0を目指していきましょう！') do |ct|
  ct.character_expression_id = expression_happy.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_tier3.id, text: '残りの積みゲーも、楽しんでプレイしていきましょうねっ！') do |ct|
  ct.character_expression_id = expression_happy.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_tier4.id, text: '少し積みゲーが増えてきてるみたいですね…！') do |ct|
  ct.character_expression_id = expression_neutral.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_tier5.id, text: '積みゲープレイのなかなか時間を取るのも難しいですよね…！') do |ct|
  ct.character_expression_id = expression_disappointed.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_tier6.id, text: 'ライブラリを見てみると新たな発見があるかもですね！') do |ct|
  ct.character_expression_id = expression_neutral.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_tier7.id, text: '結構な積み総額ですね…つ、次はどのゲームをプレイしましょうか！') do |ct|
  ct.character_expression_id = expression_disappointed.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_tier8.id, text: '一緒に頑張って積みゲー0を目指していきましょう！') do |ct|
  ct.character_expression_id = expression_neutral.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_tier9.id, text: '長い道のりになりそうですが一つずつプレイしていきましょう！') do |ct|
  ct.character_expression_id = expression_disappointed.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_tier10.id, text: 'なかなかの積み具合ですね…気長にいきましょう！') do |ct|
  ct.character_expression_id = expression_shock.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_gift_show.id, text: 'ありがとうございます、嬉しいですっ！') do |ct|
  ct.character_expression_id = expression_happy.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_gift_show_lv2.id, text: 'いいんですかいただいちゃって！ありがとうございますっ！') do |ct|
  ct.character_expression_id = expression_happy.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_gift_show_lv3.id, text: 'いつもありがとうございますっ！') do |ct|
  ct.character_expression_id = expression_happy.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_gift_show_lv4.id, text: '私もお返しできるよう、これからもサポートしていきますね！') do |ct|
  ct.character_expression_id = expression_happy.id
end

# タスク(積みゲー消化)
tsumige_first_five_points = { 1 => 200, 2 => 250, 3 => 300, 4 => 350, 5 => 400 }
(1..100).each do |n|
  task = Task.find_or_create_by!(name: "ゲームを#{n}本クリアする", task_genre: :tsumige) do |t|
    t.description = "積みゲーを#{n}本クリアする"
  end
  TaskCondition.find_or_create_by!(task_id: task.id) do |tc|
    tc.condition_type = :tsumige
    tc.required_count = n
  end
  point = tsumige_first_five_points[n] || ((n % 10).zero? ? 300 : (n % 5).zero? ? 250 : 200)
  TaskReward.find_or_initialize_by(task_id: task.id).update!(point: point)
end

# タスク(プレイ時間)
playtime_tiers = { 100 => 5, 500 => 5, 1_000 => 5, 5_000 => 5, 10_000 => 10 }
(20_000..1_000_000).step(10_000).each { |n| playtime_tiers[n] = 5 }

playtime_tiers.each do |n, point|
  task = Task.find_or_create_by!(name: "合計プレイ時間#{n}分を達成する", task_genre: :playtime) do |t|
    t.description = "積みゲーを含む全ゲームの合計プレイ時間が#{n}分を超える"
  end
  TaskCondition.find_or_create_by!(task_id: task.id) do |tc|
    tc.condition_type = :playtime
    tc.required_count = n
  end
  TaskReward.find_or_create_by!(task_id: task.id) do |tr|
    tr.point = point
  end
end

# タスク(キャラクター好感度、レベル1は初回ですでに到達済みのため除外)
friendship_task_points = { 2 => 20, 3 => 30, 4 => 40, 5 => 50 }
UserCharacter::FRIENDSHIP_LEVEL_THRESHOLDS.except(1).each do |level, required_point|
  task = Task.find_or_create_by!(name: "キャラクターとの好感度レベル#{level}に到達する", task_genre: :friendship_level) do |t|
    t.description = "キャラクターとの好感度がレベル#{level}に到達する"
  end
  TaskCondition.find_or_create_by!(task_id: task.id) do |tc|
    tc.condition_type = :friendship_level
    tc.required_count = required_point
  end
  TaskReward.find_or_initialize_by(task_id: task.id).update!(point: friendship_task_points[level])
end

# ギフトアイテム
gift_item1 = GiftItem.find_or_initialize_by(name: 'イチゴのショートケーキ')
gift_item1.update!(
  friendship_point: 10,
  image_path: 'https://res.cloudinary.com/dvswzgioa/image/upload/v1786865844/00147strawberry-shortcake_sr4mq7.png',
  description: "プレゼント用アイテム。\n謹厳実直なパティシエによる至福の一品。"
)

gift_item2 = GiftItem.find_or_initialize_by(name: '可愛いクマのぬいぐるみ')
gift_item2.update!(
  friendship_point: 30,
  image_path: 'https://res.cloudinary.com/dvswzgioa/image/upload/v1786865844/stuffed-bear_brown_heart_tymegv.png',
  description: "プレゼント用アイテム。\n密かなブームを起こしているぬいぐるみ。いつだって君の味方。"
)

gift_item3 = GiftItem.find_or_initialize_by(name: '手紙')
gift_item3.update!(
  friendship_point: 50,
  image_path: 'https://res.cloudinary.com/dvswzgioa/image/upload/v1786865844/%E6%89%8B%E7%B4%99-%E3%82%A4%E3%83%A9%E3%82%B9%E3%83%88-%E3%81%8B%E3%82%8F%E3%81%84%E3%81%84_x1pjrh.png',
  description: "プレゼント用アイテム。\n素直に気持ちを伝えるには手紙が一番。"
)

# ショップ商品
ShopItem.find_or_create_by!(item_type: 'GiftItem', item_id: gift_item1.id) do |si|
  si.price = 100.0
end

ShopItem.find_or_create_by!(item_type: 'GiftItem', item_id: gift_item2.id) do |si|
  si.price = 280.0
end

ShopItem.find_or_create_by!(item_type: 'GiftItem', item_id: gift_item3.id) do |si|
  si.price = 450.0
end


=begin
#ユーザー指定
user = User.find_or_create_by(uid: '76561198369759270')

#ユーザーキャラ
UserCharacter.find_or_create_by!(user_id: user.id, character_type_id: character_type.id) do |uc|
  uc.name = 'ユーザー命名'
  uc.friendship_point = 0
  uc.outfit_item_id = nil
end
=end
