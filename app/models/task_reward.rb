class TaskReward < ApplicationRecord
    belongs_to :task
    belongs_to :item, polymorphic: true, optional: true

    validate :item_or_point_presence

    def give_rewards(user)
        if point.present?
            user.user_wallet.increment!(:point, point)
        elsif item_type == 'GiftItem'
            user_gift_item = user.user_gift_items.find_or_create_by!(gift_item_id: item_id) do |ugi|
                ugi.quantity = 0
            end
            user_gift_item.increment!(:quantity, quantity)
        elsif item_type == 'OutfitItem'
            user.user_outfit_items.find_or_create_by!(outfit_item_id: item_id)
        end
    end

    private

    def item_or_point_presence
        if (item.nil? && point.nil?) || (item.present? && point.present?)
            errors.add(:base, "アイテムかポイントのどちらか一方だけを設定してください")
        end
    end
end
