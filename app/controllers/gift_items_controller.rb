class GiftItemsController < ApplicationController
    before_action :set_user_character

    def index
        @user_gift_items = current_user.user_gift_items
    end

    def show
        @user_gift_item = current_user.user_gift_items.find(params[:id])
    end

    def present_gift
        gift_item = GiftItem.find(params[:gift_item_id])
        count = params[:count].to_i
        GiftItem.present_gift_process(current_user, @user_character, gift_item, count)
        @current_user_gift_item = current_user.user_gift_items.find_by(gift_item_id: gift_item.id)
    end

    private

    def set_user_character
        @user_character = current_user.user_characters.find(params[:user_character_id])
        @page = 'user_characters_gift_show'
        @total_price = UserGameLibrary.total_price(current_user)
        @character_text = CharacterTextService.new.get_character_text(@user_character, @page, @total_price)
        @character_expression = @character_text.character_expression
    end
end
