# character_type
character_type = CharacterType.find_or_create_by!(name: 'いらすと子') do |ct|
  ct.image_path = 'https://res.cloudinary.com/dvswzgioa/image/upload/q_auto/f_auto/v1777086275/business_woman1_1_smile_ujoauq.png'
end

# 総額ごとのconditions
condition_show_min = CharacterTextCondition.find_or_create_by!(character_type_id: character_type.id, page: 'users_show', friendship_level: 1, min_price: 0, max_price: 0)

condition_show_low = CharacterTextCondition.find_or_create_by!(character_type_id: character_type.id, page: 'users_show', friendship_level: 1, min_price: 1, max_price: 5000)

condition_show_med = CharacterTextCondition.find_or_create_by!(character_type_id: character_type.id, page: 'users_show', friendship_level: 1, min_price: 5001, max_price: 10000)

condition_show_high = CharacterTextCondition.find_or_create_by!(character_type_id: character_type.id, page: 'users_show', friendship_level: 1, min_price: 10001, max_price: 30000)

condition_show_max = CharacterTextCondition.find_or_create_by!(character_type_id: character_type.id, page: 'users_show', friendship_level: 1, min_price: 30001, max_price: nil)

condition_communicate_show = CharacterTextCondition.find_or_create_by!(character_type_id: character_type.id, page: 'user_characters_show', friendship_level: 1, min_price: 0, max_price: 999999999)

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

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_show.id, text: 'こんにちわんわん！') do |ct|
  ct.character_expression_id = expression_happy.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_show.id, text: 'こんにちジョン！') do |ct|
  ct.character_expression_id = expression_happy.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_show.id, text: 'こんにちリチャード！') do |ct|
  ct.character_expression_id = expression_happy.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_show.id, text: 'こんにちアニス！') do |ct|
  ct.character_expression_id = expression_happy.id
end

ct = CharacterText.find_or_create_by!(character_text_condition_id: condition_communicate_show.id, text: 'こんにちファブル！') do |ct|
  ct.character_expression_id = expression_happy.id
end

# タスク(積みゲー消化)
(1..7).each do |n|
  task = Task.find_or_create_by!(name: "積みゲーを#{n}本消化する", task_genre: :tsumige) do |t|
    t.description = "積みゲーを#{n}本クリアする"
  end
  TaskCondition.find_or_create_by!(task_id: task.id) do |tc|
    tc.condition_type = :tsumige
    tc.required_count = n
  end
  TaskReward.find_or_create_by!(task_id: task.id) do |tr|
    tr.point = 100
  end
end

# タスク(プレイ時間)
task = Task.find_or_create_by!(name: '合計プレイ時間600分を達成する', task_genre: :playtime) do |t|
  t.description = '積みゲーを含む全ゲームの合計プレイ時間が600分を超える'
end
TaskCondition.find_or_create_by!(task_id: task.id) do |tc|
  tc.condition_type = :playtime
  tc.required_count = 600
end
TaskReward.find_or_create_by!(task_id: task.id) do |tr|
  tr.point = 100
end

# タスク(キャラクター好感度)
task = Task.find_or_create_by!(name: 'キャラクターとの好感度100を達成する', task_genre: :friendship_level) do |t|
  t.description = 'キャラクターとの好感度が100を超える'
end
TaskCondition.find_or_create_by!(task_id: task.id) do |tc|
  tc.condition_type = :friendship_level
  tc.required_count = 100
end
TaskReward.find_or_create_by!(task_id: task.id) do |tr|
  tr.point = 100
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
