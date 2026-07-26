module ShopItemsHelper
  def shop_item_owned?(shop_item, owned_outfit_item_ids)
    shop_item.item_type == 'OutfitItem' && owned_outfit_item_ids.include?(shop_item.item_id)
  end
end
