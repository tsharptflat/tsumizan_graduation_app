class GiftItem < ApplicationRecord
    has_many :user_gift_items, dependent: :destroy
    has_many :users, through: :user_gift_items
    has_many :task_rewards, as: :item, dependent: :destroy
    has_many :shop_items, as: :item, dependent: :destroy

    def self.present_gift_process(user, user_character, gift_item, count)
        ActiveRecord::Base.transaction do
            possessed_user_gift_item = user.user_gift_items.find_by(gift_item_id: gift_item.id)
            possessed_user_gift_item.decrement!(:quantity, count)
            user_character.increment!(:friendship_point, gift_item.friendship_point*count)
        end
    end
end
