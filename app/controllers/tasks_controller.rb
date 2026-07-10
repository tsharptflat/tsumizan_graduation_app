class TasksController < ApplicationController
  def index
    @obtainable_user_tasks_total_count = current_user.user_tasks.obtainable.count
    
    obtainable_user_tasks_by_genre_count = current_user.user_tasks.obtainable.joins(:task).group('tasks.task_genre').count
    @tsumige_count = obtainable_user_tasks_by_genre_count['tsumige']
    @playtime_count = obtainable_user_tasks_by_genre_count['playtime']
    @trophies_count = obtainable_user_tasks_by_genre_count['trophies']
    @friendship_count = obtainable_user_tasks_by_genre_count['friendship_level']

    @user_wallet = current_user.user_wallet

  end

  def show
    @tasks = Task.where(task_genre: params[:id]).includes(:task_rewards)
    @user_tasks_by_task_id = current_user.user_tasks.index_by(&:task_id)
  end

  def obtain_all_rewards
    UserTask.obtain_all_rewards(current_user)
    redirect_back(fallback_location: root_path, notice: 'タスク報酬を受け取りました。')
  end
end
