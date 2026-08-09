class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!, unless: :devise_controller?
  before_action :set_search
  before_action :save_user_statistic_snapshot, if: :user_signed_in?
  before_action :set_now_playing_libraries, if: :user_signed_in?

  def after_sign_in_path_for(resource)
    loading_user_game_libraries_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def set_search
    @q = Game.ransack(params[:q])
  end

  def save_user_statistic_snapshot
    return if session[:snapshot_recorded_on] == Date.current.to_s

    UserStatisticSnapshot.record_for(current_user)
    session[:snapshot_recorded_on] = Date.current.to_s
  rescue => e
    Rails.logger.error(e.message)
  end

  def set_now_playing_libraries
    @now_playing_libraries = current_user.user_game_libraries.now_playing.includes(:game)
  end

end
