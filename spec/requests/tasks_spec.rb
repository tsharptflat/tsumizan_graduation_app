require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user) { create(:user) }

  before do
    # ログイン中は全ページで初期キャラ(いらすと子)を自動作成するため、そのキャラ種別を用意しておく
    create(:character_type, name: 'いらすと子')
    # 本番ではSteamログイン時に作成されるポイント残高(UserWallet)も用意しておく
    create(:user_wallet, user: user)
    sign_in user
  end

  describe "GET /tasks" do
    it "returns http success" do
      get tasks_path
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
