class OutfitItem < ApplicationRecord
  has_many :user_characters, dependent: :nullify
  has_many :user_outfit_items, dependent: :destroy
  has_many :users, through: :user_outfit_items
  has_many :task_rewards, as: :item, dependent: :destroy
  has_many :shop_items, as: :item, dependent: :destroy

  validates :name, presence: true
end
