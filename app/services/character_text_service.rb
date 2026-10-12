class CharacterTextService
  # exclude_id: 直前に表示していたセリフのID。同じセリフが2回連続で選ばれないよう候補から外す
  def get_character_text(user_character, page, total_price, exclude_id = nil)
    character_type = user_character.character_type
    conditions = CharacterTextCondition.where(character_type_id: character_type.id).where(page: page).where('min_price <= ? AND (max_price IS NULL OR max_price >= ? )', total_price, total_price).where('friendship_level <= ?', user_character.current_friendship_level)
    texts = conditions.flat_map(&:character_texts)
    candidates = texts.reject { |text| text.id == exclude_id }
    # 候補のセリフが1つしかない場合は、除外すると空になるため全体から選ぶ
    (candidates.presence || texts).sample
  end
end
