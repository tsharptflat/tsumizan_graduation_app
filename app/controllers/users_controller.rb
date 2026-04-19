class UsersController < ApplicationController
  def loading
  end

  def show
    @total_price = current_user.games.sum(:price)
  end
end
