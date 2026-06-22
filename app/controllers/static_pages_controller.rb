class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def top
    @unplayed_price_and_count_ranking_users = User.all.map { |user| [user, UserGameLibrary.total_price(user), UserGameLibrary.total_games_count(user)]}.sort_by { |data| -data[1] }.first(User::TOP_PAGE_USER_RANKINGS)
  end
end
