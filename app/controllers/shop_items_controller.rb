class ShopItemsController < ApplicationController
    def index
        @user_gift_items = current_user.user_gift_items
        @user_outfit_items = current_user.user_outfit_items
        @owned_outfit_item_ids = @user_outfit_items.pluck(:outfit_item_id)
        @shop_items = ShopItem.includes(:item).all
    end

    def purchase_item
        @shop_item = ShopItem.find(params[:id])
        @count = @shop_item.item_type == 'GiftItem' ? params[:count].to_i : 1
        @purchase_success = ShopItem.purchase_item_process(current_user, @shop_item, @count)
    end
end
