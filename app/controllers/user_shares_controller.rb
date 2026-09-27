class UserSharesController < ApplicationController
    allow_browser versions: {}
    skip_before_action :authenticate_user!

    def show
        user = User.find_by(id: params[:id])
        # 動的OGP画像生成(ogp_image_url)はX上で表示されない問題が解決しなかったため、静的画像に切り替え
        # TODO: 現状は仮画像(ogp_background_image.png、旧・動的OGP生成の背景素材を流用)。
        # 本番用の画像ができ次第、専用の静的OGP画像ファイルに差し替える。
        static_ogp_image = view_context.image_url('ogp_background_image.png')
        set_meta_tags og: { image: static_ogp_image }, twitter: { card: 'summary_large_image', image: static_ogp_image }
    end
end