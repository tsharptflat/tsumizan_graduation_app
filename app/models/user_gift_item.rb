class UserGiftItem < ApplicationRecord
    belongs_to :user
    belongs_to :gift_item
end
