class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def top
    @users = User.all.sort_by { |user| -UserGameLibrary.total_games_count(user) }.first(User::TOP_PAGE_USER_RANKINGS)
  end
end
