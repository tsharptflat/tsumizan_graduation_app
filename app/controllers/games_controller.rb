class GamesController < ApplicationController
    def  index

    end

    def show
        @user = current_user
        所持者数
        積み率
        クリア率
        自分の積み/クリア状況
        平均プレイ時間
        自分のプレイ時間
        平均積み期間
        自分の積み時間
        ジャンル
        価格
        ストアリンク
    end
end
