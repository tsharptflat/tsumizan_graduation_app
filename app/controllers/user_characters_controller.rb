class UserCharactersController < ApplicationController
    before_action :set_character_texts, only: [:show, :communicate]

    def index
    end

    def show
    end

    def communicate
    end

    private

    def set_character_texts
        @page = 'user_characters_show'
        @total_price = UserGameLibrary.total_price(current_user)
        @user_character = current_user.user_characters.find(params[:id])
        @character_text = CharacterTextService.new.get_character_text(@user_character, @page, @total_price)
        @character_expression = @character_text.character_expression
    end
end
