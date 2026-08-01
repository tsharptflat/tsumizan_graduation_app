class UsersController < ApplicationController
  def show
    @user = current_user
    @page = 'users_show'
    @total_price = UserGameLibrary.total_price(current_user)
    text_page = UserGameLibrary.any_library_game_prices_nil?(current_user) ? 'users_show_loading' : @page
    @character_text = CharacterTextService.new.get_character_text(current_user.user_characters.first, text_page, @total_price)
    @character_expression = @character_text.character_expression
  end

  def destroy
    current_user.destroy!
    sign_out current_user
    redirect_to root_path
  end
end
