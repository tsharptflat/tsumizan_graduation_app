class GiftItem < ApplicationRecord
    has_many :user_gift_items, dependent: :destroy
    has_many :users, through: :user_gift_items
    has_many :task_rewards, as: :item, dependent: :destroy
    has_many :shop_items, as: :item, dependent: :destroy

    def self.present_gift_process(user, user_character, gift_item, count)
        ActiveRecord::Base.transaction do
            return false if count < 1

            possessed_user_gift_item = user.user_gift_items.find_by(gift_item_id: gift_item.id)
            return false if possessed_user_gift_item.nil? || possessed_user_gift_item.quantity < count

            possessed_user_gift_item.update!(quantity: possessed_user_gift_item.quantity - count)
            user_character.update!(friendship_point: user_character.friendship_point + gift_item.friendship_point * count)

            true
        end
    end
end
