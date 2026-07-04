class ShopItem < ApplicationRecord
    belongs_to :item, polymorphic: true
end
