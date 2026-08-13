class TasksController < ApplicationController
  GENRES = [
    ['tsumige', '積みゲー消化'],
    ['playtime', 'プレイ時間？'],
    ['friendship_level', 'キャラ好感度']
  ].freeze

  def index
    @user_wallet = current_user.user_wallet
    @user_tasks_by_task_id = current_user.user_tasks.index_by(&:task_id)
    @tasks_by_genre = Task.includes(:task_rewards).all.group_by(&:task_genre)
    @tasks_by_genre.transform_values! do |tasks|
      not_claimed, claimed = tasks.partition { |task| @user_tasks_by_task_id[task.id]&.accepted_reward_at.blank? }
      not_claimed + claimed
    end
    @obtainable_counts_by_genre = current_user.user_tasks.obtainable.joins(:task).group('tasks.task_genre').count
    @obtainable_user_tasks_total_count = current_user.user_tasks.obtainable.count
  end

  def obtain_reward
    task = Task.find(params[:id])
    UserTask.obtain_reward(current_user, task)
    redirect_back(fallback_location: root_path, notice: 'タスク報酬を受け取りました。')
  end

  def obtain_all_rewards
    UserTask.obtain_all_rewards(current_user)
    redirect_back(fallback_location: root_path, notice: 'タスク報酬を受け取りました。')
  end
end
