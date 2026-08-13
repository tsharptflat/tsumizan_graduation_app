class PlayFocusController < ApplicationController
  def show
    @next_up_library = current_user.user_game_libraries.next_up.includes(:game).first
  end

  def picker
    @slot = params[:slot]
    @cleared_filter = params[:cleared]
    @available_libraries = current_user.user_game_libraries.unfocused.includes(:game).joins(:game).order('games.game_title')
    @available_libraries = @available_libraries.where('games.game_title ILIKE ?', "%#{params[:q]}%") if params[:q].present?
    @available_libraries = @available_libraries.cleared if @cleared_filter == 'cleared'
    @available_libraries = @available_libraries.not_cleared if @cleared_filter == 'uncleared'
    @available_libraries = @available_libraries.unplayed if @cleared_filter == 'unplayed'
    @available_libraries = @available_libraries.page(params[:page])
  end

  def set_slot
    library = current_user.user_game_libraries.find(params[:library_id])

    if params[:slot] == 'next_up'
      current_user.user_game_libraries.next_up.where.not(id: library.id).update_all(play_focus: :unfocused)
    end

    if library.update(play_focus: params[:slot])
      redirect_to play_focus_path, notice: '設定しました。'
    else
      redirect_to play_focus_path, alert: library.errors.full_messages.to_sentence
    end
  end

  def clear_slot
    library = current_user.user_game_libraries.find(params[:library_id])
    library.update(play_focus: :unfocused)
    redirect_to play_focus_path, notice: '取り下げました。'
  end

  def update_cleared_games
    library = current_user.user_game_libraries.find(params[:library_id])
    library.update!(cleared_date: Time.current)
    redirect_back fallback_location: play_focus_path, notice: 'クリア済みにしました。'
  rescue
    redirect_back fallback_location: play_focus_path, alert: '更新に失敗しました。'
  end

  def revert_cleared_games
    library = current_user.user_game_libraries.find(params[:library_id])
    library.update!(cleared_date: nil)
    redirect_back fallback_location: play_focus_path, notice: '未クリアに戻しました。'
  rescue
    redirect_back fallback_location: play_focus_path, alert: '更新に失敗しました。'
  end
end
