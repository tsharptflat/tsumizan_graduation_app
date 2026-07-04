class UserOutfitItem < ApplicationRecord
    belongs_to :user
    belongs_to :outfit_item
end
