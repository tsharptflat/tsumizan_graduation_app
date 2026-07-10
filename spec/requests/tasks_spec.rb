require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET /tasks" do
    it "returns http success" do
      get tasks_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /tasks/:id" do
    it "returns http success" do
      task = create(:task, task_genre: :tsumige)
      create(:task_reward, task: task)
      get task_path('tsumige')
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /tasks/obtain_all_rewards" do
    it "redirects back" do
      patch obtain_all_rewards_tasks_path
      expect(response).to have_http_status(:redirect)
    end
  end
end
