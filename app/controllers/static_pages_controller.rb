class StaticPagesController < ApplicationController
  def top
    @users = User.all.limit(User::TOP_PAGE_USER_RANKINGS)
  end
end
