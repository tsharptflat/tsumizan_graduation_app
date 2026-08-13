class ShopItem < ApplicationRecord
    belongs_to :item, polymorphic: true

    def affordable_count_for(user)
        return 0 if price.to_i <= 0

        user.user_wallet.point / price.to_i
    end

    def self.purchase_item_process(user, shop_item, quantity)
        ActiveRecord::Base.transaction do
            return false if quantity < 1

            possessed_user_points = user.user_wallet
            total_shop_items_price = shop_item.price * quantity
            return false if shop_item.item_type == "OutfitItem" && user.user_outfit_items.exists?(outfit_item_id: shop_item.item_id)
            return false if possessed_user_points.point < total_shop_items_price

            possessed_user_points.update!(point: possessed_user_points.point - total_shop_items_price)

            if shop_item.item_type == 'GiftItem'
                user_gift_item = user.user_gift_items.find_or_create_by!(gift_item_id: shop_item.item.id) do |ugi|
                    ugi.quantity = 0
                end
                user_gift_item.increment!(:quantity, quantity)
            elsif shop_item.item_type == 'OutfitItem'
                user.user_outfit_items.find_or_create_by!(outfit_item_id: shop_item.item.id)
            end

            true
        end
    end
end
