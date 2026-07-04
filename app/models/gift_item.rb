class GiftItem < ApplicationRecord
    has_many :user_gift_items, dependent: :destroy
    has_many :users, through: :user_gift_items
    has_many :task_rewards, as: :item, dependent: :destroy
    has_many :shop_items, as: :item, dependent: :destroy
end
